"""Offline checks: python Documentos/6_MOMENTO/testar_modelo.py."""
import copy
import json
import unittest
from datetime import datetime
from decimal import Decimal
from gerar_dados import ROOT, build


def validate(value, rule):
    if value is None:
        kind = 'null'
    elif isinstance(value, dict) and '$date' in value:
        kind = 'date'
        datetime.fromisoformat(value['$date'])
    elif isinstance(value, dict) and '$numberDecimal' in value:
        kind = 'decimal'
        assert Decimal(value['$numberDecimal']) >= 0
    elif isinstance(value, dict):
        kind = 'object'
    elif isinstance(value, list):
        kind = 'array'
    elif isinstance(value, int):
        kind = 'int'
    else:
        kind = 'string'
    allowed = rule['bsonType']
    assert kind in (allowed if isinstance(allowed, list) else [allowed])
    if 'enum' in rule:
        assert value in rule['enum']
    if kind == 'int' and 'minimum' in rule:
        assert value >= rule['minimum']
    if kind == 'object':
        assert set(rule['required']) <= value.keys()
        assert value.keys() <= rule['properties'].keys()
        for key, item in value.items():
            validate(item, rule['properties'][key])
    if kind == 'array':
        for item in value:
            validate(item, rule['items'])


class ModelTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.collections = build()
        cls.rules = {r['nome']: r['schema'] for r in json.loads((ROOT / 'configuracao.json').read_text(encoding='utf-8'))}
        cls.data = {name: json.loads((ROOT / (stem + '.json')).read_text(encoding='utf-8')) for stem, name, _ in cls.collections}

    def test_exports_match_current_source(self):
        for _, name, expected in self.collections:
            self.assertEqual(self.data[name], expected, name)

    def test_all_documents_satisfy_declared_shape(self):
        for name, docs in self.data.items():
            for doc in docs:
                validate(doc, self.rules[name])
            self.assertEqual(len(docs), len({d['_id'] for d in docs}))

    def test_references_and_audit_identity(self):
        ids = {name: {d['_id'] for d in docs} for name, docs in self.data.items()}
        for name, links in {
            'escritorios': {'pais_id': 'paises'},
            'paises': {'regiao_id': 'regioes'},
            'departamentos': {'escritorio_id': 'escritorios'},
            'funcionarios': {'cargo_id': 'cargos', 'gerente_id': 'funcionarios', 'departamento_id': 'departamentos'},
            'vendas': {'produto_id': 'produtos', 'funcionario_id': 'funcionarios'},
            'log': {'funcionario_id': 'funcionarios'},
        }.items():
            for doc in self.data[name]:
                for field, target in links.items():
                    self.assertTrue(doc[field] is None or doc[field] in ids[target])
        people = {d['_id']: d for d in self.data['funcionarios']}
        for event in self.data['log']:
            self.assertEqual(event['autor'], {k: people[event['funcionario_id']][k] for k in ('primeiro_nome', 'sobrenome', 'email')})
        snapshot = copy.deepcopy(self.data['log'][0])
        del people[snapshot['funcionario_id']]
        self.assertTrue(snapshot['autor']['email'])

    def test_invalid_documents_are_rejected_by_schema_contract(self):
        event = copy.deepcopy(self.data['log'][0])
        for field, invalid in [('status', 'INVALIDO'), ('data', '2024-01-01'), ('extra', True)]:
            changed = dict(event, **{field: invalid})
            with self.assertRaises(AssertionError):
                validate(changed, self.rules['log'])
        person = copy.deepcopy(self.data['funcionarios'][0])
        person['salario'] = 1000.0
        with self.assertRaises(AssertionError):
            validate(person, self.rules['funcionarios'])
        sale = dict(self.data['vendas'][0], quantidade=-1)
        with self.assertRaises(AssertionError):
            validate(sale, self.rules['vendas'])


if __name__ == '__main__':
    unittest.main()
