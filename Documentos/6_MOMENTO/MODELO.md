# Modelo documental da Momento

## Fonte e geração

`Tabelas/8_MOMENTO/0_Base.sql` é a fonte dos dados iniciais. Na raiz do repositório:

```powershell
python Documentos/6_MOMENTO/gerar_dados.py
```

O gerador usa somente a biblioteca padrão do Python. Ele executa o SQL em memória com adaptações de sintaxe para SQLite e verifica as referências antes de escrever os arquivos. Não altera o SQL nem se conecta ao MongoDB. Edite os dados na fonte e gere novamente; não mantenha cópias manualmente.

Os nove arquivos numerados `.json` são arrays em MongoDB Extended JSON v2. Os scripts `.js` leem esses arquivos com `EJSON.parse`, preservando os tipos BSON. `configuracao.json`, `0_configurar.js` e `importar.js` também são gerados.

## Coleções

| Arquivo | Coleção | Conteúdo e referências |
| --- | --- | --- |
| `1_escritorios.json` | `escritorios` | Endereço, `pais_id` e array `suprimentos` |
| `2_departamentos.json` | `departamentos` | Nome e `escritorio_id` |
| `3_funcionarios.json` | `funcionarios` | Identidade, contratação, salário, `cargo_id`, `gerente_id`, `departamento_id` e array `dependentes` |
| `4_vendas.json` | `vendas` | `produto_id`, `funcionario_id`, quantidade e data |
| `5_log.json` | `log` | Ação, data, módulo, status, origem, detalhes e autor |
| `6_produtos.json` | `produtos` | Nome e `preco_unitario` |
| `7_paises.json` | `paises` | Nome e `regiao_id` |
| `8_regioes.json` | `regioes` | Nome |
| `9_cargos.json` | `cargos` | Nome, `salario_minimo` e `salario_maximo` |

`_id` corresponde à chave primária SQL. Países usam o código textual de dois caracteres; os demais IDs são inteiros. Referências usam um único campo com sufixo `_id`. Subdocumentos de suprimentos e dependentes conservam seus IDs, sem repetir a referência ao documento pai.

Os nomes completos dos funcionários são calculados a partir de `primeiro_nome` e `sobrenome`. Cargos e produtos são consultados por referência, sem repetir seus nomes em funcionários ou vendas. Departamentos e escritórios também são referências. Dependentes formam um array único com `relacionamento`, preservando todos os relacionamentos do SQL.

## Tipos e valores

- Datas são BSON Date: `{"$date": "2024-11-11T08:00:00.000Z"}`. Como o SQL não informa fuso, a base de exercícios adota UTC; isso não afirma o fuso real dos eventos originais.
- Dinheiro é Decimal128 com duas casas: `{"$numberDecimal": "300.13"}`. Nas consultas use `NumberDecimal("300.13")`.
- Ausências são `null`; arrays sem elementos são `[]`.
- `custo` de suprimentos conserva o significado não especificado do SQL. Não é renomeado para preço unitário nem multiplicado automaticamente pela quantidade.
- Vendas não recebem um preço histórico inventado. Para estimar receita, faça `$lookup` em `produtos` e multiplique a quantidade pelo preço atual do catálogo. Essa estimativa muda se o catálogo mudar.
- As senhas temáticas são dados fictícios para os exercícios, sem finalidade de autenticação real.

## Importação

Com MongoDB e mongosh disponíveis, entre nesta pasta e execute:

```powershell
mongosh --file importar.js
```

O destino é explicitamente o banco `momento`. Configure a conexão/autenticação do mongosh conforme o seu ambiente. O script configura validação e índices antes de carregar os documentos. Registros existentes com o mesmo `_id` são substituídos pelos dados gerados, exceto auditoria: eventos existentes são preservados com `$setOnInsert`. Não há remoção automática de documentos que deixaram de existir na fonte. A carga não é uma transação global; após uma falha, corrija a causa e execute novamente.

Para importação manual dos JSONs, execute primeiro `0_configurar.js` e utilize `mongoimport --jsonArray` com o arquivo e a coleção correspondentes. O caminho recomendado é `importar.js`, que já trata a repetição da carga.

Bases carregadas no modelo antigo precisam de uma migração separada. Os antigos `ObjectId` e aliases não são convertidos pela importação. Use uma base Momento vazia para estes exercícios ou faça backup e planeje a migração antes de aplicar os scripts a uma base existente. A configuração não remove registros incompatíveis e a criação do índice único de email pode recusar duplicatas preexistentes.

## Validação, índices e auditoria

Cada coleção possui `$jsonSchema` com campos obrigatórios, tipos BSON, estrutura dos subdocumentos e rejeição de campos desconhecidos. Valores monetários são não negativos; status de auditoria aceita somente `REGISTRADO`, `SUCESSO`, `FALHA` e `BLOQUEADO`. Regras de referências entre coleções continuam sendo responsabilidade da aplicação; MongoDB não cria chaves estrangeiras a partir desses schemas. A geração valida as referências do conjunto inicial no SQL.

Email possui índice único. Há índices nas referências de funcionários, escritórios, departamentos e países, além de índices de vendas e auditoria por data, funcionário, módulo e status. `_id` usa o índice nativo do MongoDB.

Auditoria guarda `funcionario_id` e o snapshot `autor` com nome e email. Essa duplicação é intencional: renomear ou excluir um funcionário não deve reescrever a identidade histórica. Para os dados iniciais, o snapshot vem do cadastro disponível no SQL; a fonte não possui versões históricas dos nomes. Não existe exclusão em cascata nem TTL para logs. O importador preserva eventos já existentes, mas validators não impedem updates/deletes autorizados. A aplicação deve inserir novos eventos com horário fixo e operar com permissão de leitura/inserção, sem atualização ou exclusão na coleção `log`.

O script opcional `permissoes_auditoria.js` cria a role `momento_auditoria`, limitada a `find` e `insert` em `momento.log`. Ele não é executado pela importação nem atribui permissões a usuários. Um administrador pode executá-lo e atribuir a role ao usuário da aplicação; permissões adicionais de outras roles continuam valendo. Use credenciais distintas para importação/administração e para a aplicação.

## Verificação local

Na raiz do repositório, execute `python Documentos/6_MOMENTO/testar_modelo.py`. Os testes verificam a sincronização com o SQL atual, IDs, referências, estrutura e tipos declarados, snapshots e rejeição de documentos inválidos pelo contrato local. Eles não substituem um teste de integração com o servidor MongoDB.

## Adaptação dos exercícios

| Modelo anterior | Modelo atual |
| --- | --- |
| `nome` completo do funcionário | `primeiro_nome` + `sobrenome` |
| `dataAdmissao` | `data_contratacao` (BSON Date) |
| `departamento`, `gerente`, `escritorio` | `departamento_id`, `gerente_id`, `escritorio_id` |
| `cargo` textual no funcionário | `cargo_id` + `$lookup` em `cargos` |
| `dependentes.filhos` / `dependentes.conjuge` | Array `dependentes`, filtrado por `relacionamento` |
| `vendedor` | `funcionario_id` |
| `dataVenda` | `data_venda` (BSON Date) |
| `produto`, `precoUnitario` na venda | `produto_id` + `$lookup` em `produtos` |
| `usuario` no log | `funcionario_id` e snapshot `autor` |
| `ObjectId("...")` | ID numérico do SQL (países continuam códigos textuais) |

Exemplos:

```javascript
db.funcionarios.find({departamento_id: 6, salario: {$gt: NumberDecimal("7000.00")}});
db.funcionarios.find({dependentes: {$elemMatch: {relacionamento: "Filha(o)"}}});
db.vendas.find({data_venda: {$gte: ISODate("2023-06-01"), $lt: ISODate("2023-07-01")}});
db.log.find({status: {$in: ["FALHA", "BLOQUEADO"]}}).sort({data: -1});
```
