"""Generate the MongoDB seed from the SQL source. Python standard library only."""
from pathlib import Path
from decimal import Decimal
import json
import re
import sqlite3

ROOT = Path(__file__).resolve().parent
SOURCE = ROOT.parent.parent / 'Tabelas/8_MOMENTO/0_Base.sql'


def money(value):
    return None if value is None else {'$numberDecimal': str(Decimal(str(value)).quantize(Decimal('0.01')))}


def date(value):
    # The source has no timezone. UTC is the documented seed convention.
    return {'$date': value.replace(' ', 'T') + ('T00:00:00' if len(value) == 10 else '') + '.000Z'}


def dump(value):
    return json.dumps(value, ensure_ascii=False, indent=4, allow_nan=False)


def schema(values, field=''):
    """Describe the seed shape, allowing nullable SQL fields even when populated."""
    nullable = {'telefone', 'gerente_id', 'escritorio_id', 'cep', 'origem', 'detalhes',
                'salario_minimo', 'salario_maximo', 'primeiro_nome'}
    present = [v for v in values if v is not None]
    if not present:
        kind = 'string'
    elif isinstance(present[0], dict) and '$date' in present[0]:
        kind = 'date'
    elif isinstance(present[0], dict) and '$numberDecimal' in present[0]:
        kind = 'decimal'
    elif isinstance(present[0], dict):
        keys = list(present[0])
        return {'bsonType': 'object', 'required': keys, 'additionalProperties': False,
                'properties': {k: schema([v[k] for v in present], k) for k in keys}}
    elif isinstance(present[0], list):
        items = [item for array in present for item in array]
        return {'bsonType': 'array', 'items': schema(items)}
    elif isinstance(present[0], int):
        kind = 'int'
    else:
        kind = 'string'
    result = {'bsonType': [kind, 'null'] if None in values or field in nullable else kind}
    if kind == 'decimal':
        result['minimum'] = {'$numberDecimal': '0.00'}
    if field == 'quantidade':
        result['minimum'] = 0
    if field == 'status':
        result['enum'] = ['REGISTRADO', 'SUCESSO', 'FALHA', 'BLOQUEADO']
    return result


def build():
    sql = SOURCE.read_text(encoding='utf-8')
    sql = re.sub(r'^(?:DROP DATABASE|CREATE DATABASE|USE ).*;\s*', '', sql, flags=re.M)
    sql = re.sub(r'INT (?:PRIMARY KEY AUTO_INCREMENT|AUTO_INCREMENT PRIMARY KEY)',
                 'INTEGER PRIMARY KEY AUTOINCREMENT', sql)
    db = sqlite3.connect(':memory:')
    db.row_factory = sqlite3.Row
    db.execute('PRAGMA foreign_keys = ON')
    db.executescript(sql)
    assert not db.execute('PRAGMA foreign_key_check').fetchall()

    def rows(table):
        return [dict(r) for r in db.execute('SELECT * FROM ' + table)]

    offices = [dict(_id=r['escritorio_id'], nome=r['escritorio_nome'], endereco=r['endereco'],
                    cep=r['cep'], cidade=r['cidade'], estado_provincia=r['estado_provincia'],
                    pais_id=r['pais_id'], suprimentos=[
                        dict(_id=s['suprimento_id'], nome=s['suprimento_nome'],
                             quantidade=s['quantidade_comprada'], custo=money(s['custo']))
                        for s in rows('suprimentos') if s['escritorio_id'] == r['escritorio_id']])
               for r in rows('escritorios')]
    employees = []
    for r in rows('funcionarios'):
        doc = {('_id' if k == 'funcionario_id' else k): v for k, v in r.items()}
        doc['salario'] = money(r['salario'])
        doc['data_contratacao'] = date(r['data_contratacao'])
        doc['dependentes'] = [dict(_id=d['dependente_id'], primeiro_nome=d['primeiro_nome'],
                                  sobrenome=d['sobrenome'], relacionamento=d['relacionamento'])
                              for d in rows('dependentes') if d['funcionario_id'] == r['funcionario_id']]
        employees.append(doc)
    people = {r['funcionario_id']: r for r in rows('funcionarios')}
    collections = [
        ('1_escritorios', 'escritorios', offices),
        ('2_departamentos', 'departamentos', [dict(_id=r['departamento_id'], nome=r['departamento_nome'], escritorio_id=r['escritorio_id']) for r in rows('departamentos')]),
        ('3_funcionarios', 'funcionarios', employees),
        ('4_vendas', 'vendas', [dict(_id=r['venda_id'], produto_id=r['produto_id'], quantidade=r['quantidade_vendida'], data_venda=date(r['venda_data']), funcionario_id=r['funcionario_id']) for r in rows('vendas')]),
        ('5_log', 'log', [dict(_id=r['log_id'], acao=r['log_acao'], data=date(r['log_ts']), modulo=r['log_modulo'], status=r['log_status'], origem=r['log_origem'], detalhes=r['log_detalhes'], funcionario_id=r['funcionario_id'], autor=dict(primeiro_nome=people[r['funcionario_id']]['primeiro_nome'], sobrenome=people[r['funcionario_id']]['sobrenome'], email=people[r['funcionario_id']]['email'])) for r in rows('audit_log')]),
        ('6_produtos', 'produtos', [dict(_id=r['produto_id'], nome=r['produto_nome'], preco_unitario=money(r['produto_price'])) for r in rows('produtos')]),
        ('7_paises', 'paises', [dict(_id=r['pais_id'], nome=r['pais_nome'], regiao_id=r['regiao_id']) for r in rows('paises')]),
        ('8_regioes', 'regioes', [dict(_id=r['regiao_id'], nome=r['regiao_nome']) for r in rows('regioes')]),
        ('9_cargos', 'cargos', [dict(_id=r['cargo_id'], nome=r['cargo_nome'], salario_minimo=money(r['min_salario']), salario_maximo=money(r['max_salario'])) for r in rows('cargos')]),
    ]
    # All source tables are represented, including embedded dependents and supplies.
    assert sum(len(o['suprimentos']) for o in offices) == len(rows('suprimentos'))
    assert sum(len(f['dependentes']) for f in employees) == len(rows('dependentes'))
    return collections


def main():
    collections = build()
    config = []
    indexes = {'funcionarios': [({'email': 1}, {'unique': True}), ({'departamento_id': 1}, {}), ({'cargo_id': 1}, {}), ({'gerente_id': 1}, {})],
               'departamentos': [({'escritorio_id': 1}, {})], 'escritorios': [({'pais_id': 1}, {})],
               'paises': [({'regiao_id': 1}, {})],
               'vendas': [({'funcionario_id': 1, 'data_venda': -1}, {}), ({'produto_id': 1}, {}), ({'data_venda': -1}, {})],
               'log': [({'funcionario_id': 1, 'data': -1}, {}), ({'status': 1, 'data': -1}, {}), ({'modulo': 1, 'data': -1}, {}), ({'data': -1}, {})]}
    for stem, name, documents in collections:
        text = dump(documents)
        (ROOT / (stem + '.json')).write_text(text + '\n', encoding='utf-8')
        # EJSON.parse creates BSON dates and Decimal128 rather than ordinary objects.
        operation = "updateOne: {filter: {_id: doc._id}, update: {$setOnInsert: doc}, upsert: true}" if name == 'log' else "replaceOne: {filter: {_id: doc._id}, replacement: doc, upsert: true}"
        script = ('// Gerado por gerar_dados.py. Nao editar manualmente.\n'
                  '(() => {\n  const docs = EJSON.parse(require("fs").readFileSync("' + stem + '.json", "utf8"));\n'
                  '  db.getSiblingDB("momento").getCollection("' + name + '").bulkWrite(\n'
                  '    docs.map(doc => ({' + operation + '})), {ordered: true});\n})();\n')
        (ROOT / (stem + '.js')).write_text(script, encoding='utf-8')
        config.append(dict(nome=name, schema=schema(documents), indices=indexes.get(name, [])))
        assert json.loads((ROOT / (stem + '.json')).read_text(encoding='utf-8')) == documents
        print(name, len(documents))
    setup = '''// Gerado por gerar_dados.py. Validacao estrita e indices.
(() => {
  const target = db.getSiblingDB("momento");
  const config = EJSON.parse(require("fs").readFileSync("configuracao.json", "utf8"));
  for (const entry of config) {
    const options = {validator: {$jsonSchema: entry.schema}, validationLevel: "strict", validationAction: "error"};
    if (target.getCollectionNames().includes(entry.nome)) {
      assert.commandWorked(target.runCommand({collMod: entry.nome, ...options}));
    } else {
      target.createCollection(entry.nome, options);
    }
    for (const [keys, options] of entry.indices) target.getCollection(entry.nome).createIndex(keys, options);
  }
})();
'''
    (ROOT / 'configuracao.json').write_text(dump(config) + '\n', encoding='utf-8')
    (ROOT / '0_configurar.js').write_text(setup, encoding='utf-8')
    files = ['0_configurar.js'] + [stem + '.js' for stem, _, _ in collections]
    (ROOT / 'importar.js').write_text('// Execute nesta pasta: mongosh --file importar.js\n' + '\n'.join('load(' + json.dumps(f) + ');' for f in files) + '\n', encoding='utf-8')


if __name__ == '__main__':
    main()
