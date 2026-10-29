# Momento 

Bem-vindo à base de dados da empresa **Momento**!

A Momento vende produtos de cultura pop e mantém escritórios em diferentes países, além de manter uma escola como seu projeto educacional. A equipe de dados recebeu duas fontes: uma base relacional usada pela empresa para gestão geral e um CSV exportado por um sistema de vendas recém-integrado para vendas.

Nestes exercícios, você vai explorar o banco de dados da empresa e responder perguntas que revelam insights importantes sobre o negócio. Prepare-se para usar queries básicas, agregações complexas, e operações avançadas!


## Ambiente e arquivos

Esses são os arquivos para vocês trabalharem

- [0_Base.sql](0_Base.sql)`: cria e preenche uma base MySQL para as consultas. Requer MySQL 8.0 ou superior.
- [vendas_campanha_bruto.csv](vendas_campanha_bruto.csv): exportação externa que será usada no exercício de ETL.

O script SQL usa o banco `momento` e **não apaga bancos nem tabelas existentes**. Execute-o em um banco/schema vazio. Ele cria uma área de pouso chamada `stg_vendas_csv`; essa tabela começa vazia para que a turma carregue o CSV. Os campos brutos dessa tabela são texto de propósito: a extração deve preservar os valores recebidos.

> O material é de SQL relacional e usa MySQL. As etapas de ETL podem ser feitas em SQL, Python ou Power Query, desde que o grupo documente as transformações e mantenha a rastreabilidade.

## Desafios 

Prepare dados que ajudem a equipe a responder perguntas sobre pessoas, departamentos, escritórios, produtos, vendas e atividade do sistema. Entregue consultas que possam ser explicadas e reproduzidas por outra pessoa.

---

### Etapa 0 — Explorar

Uma das técnicas mais utilizadas pelos profissional de dados é a Exploratory Data Analysis (EDA) (Análise de Dados Exploratória, em português). 

A Análise Exploratória de Dados (AED) é o processo inicial crucial de examinar, limpar e visualizar um conjunto de dados para compreender suas principais características, identificar anomalias e descobrir padrões antes de construir modelos estatísticos ou de aprendizado de máquina formais.

Objetivos principais da AED

• Descobrir padrões e estruturas: Permitir que os dados sugiram tendências e relações sem viés preestabelecido.

• Detectar anomalias e outliers: Identificar entradas corrompidas, erros de digitação ou valores extremos que distorcem os resultados.

• Lidar com dados faltantes: Decidir se deve descartar ou imputar registros incompletos usando métodos estatísticos ou de aprendizado de máquina.

Sua missão nesse momento, é explorar os dados. 

## Nível 1: Conhecendo a Empresa

### Seu Primeiro Dia na Momento

**1.1** Você acabou de ser contratado pela Momento! Vamos começar incluindo você no sistema, escolha um departamento, cargo e salário.

**1.2** Agora que você faz parte da equipe, quantos funcionários temos ao total na empresa?

**1.3** Quantos funcionários trabalham especificamente no Departamento de Tecnologia?

**1.4** Liste todos os departamentos que existem na empresa. Quantos são?

**1.5** Quantos escritórios a Momento possui? Em quais países?

---

## Nível 2: Análise Financeira Básica

O CFO precisa de relatórios urgentes sobre os custos da empresa.

**2.1** Quantos funcionários trabalham no Departamento de Vendas?

**2.2** Qual é o custo total com salários do Departamento de Vendas?

**2.3** Qual é a média salarial da empresa, excluindo os cargos de CEO, CMO e CFO?

**2.4** Qual é a média salarial do Departamento de Tecnologia?

**2.5** Qual departamento possui a maior média salarial?

**2.6** Qual departamento possui o menor número de funcionários?

---

## Nível 3: Recursos Humanos

O RH está fazendo uma análise demográfica da empresa.

**3.1** Quantos funcionários da empresa Momento possuem cônjuges?

**3.2** Quantos funcionários possuem filhos registrados?

**3.3** Qual funcionário foi contratado há mais tempo na empresa?

**3.4** Qual funcionário foi contratado há menos tempo na empresa?

**3.5** Liste os 5 funcionários com mais tempo de casa, ordenados pela data de contratação.

**3.6** Quantos funcionários foram contratados na década de 1990 (entre 1990-1999)?

**3.7** Como a média salarial da Momento evoluiu ao longo dos anos? Agrupe por ano de contratação e calcule a média salarial.

---

## Nível 4: Operações e Escritórios

**4.1** Qual é o custo total de suprimentos em cada escritório? Ordene do mais caro ao mais barato.

**4.2** Qual escritório possui a maior quantidade de diferentes tipos de suprimentos?

**4.3** Qual é o suprimento mais caro (considerando preço unitário) em toda a empresa?

**4.4** Calcule o valor total do inventário de suprimentos da empresa (quantidade × preço unitário de todos os itens em todos os escritórios).

---

## Nível 5: Produtos e Vendas

**5.1** Quais produtos foram vendidos pela Momento? Liste todos os produtos únicos.

**5.2** Qual é o produto mais vendido (maior quantidade total)?

**5.3** Qual é o produto menos vendido?

**5.4** Pensando na relação quantidade × valor unitário, qual produto gerou mais receita para a empresa?

**5.5** Qual é o produto mais caro (maior preço unitário) no catálogo?

**5.6** Qual foi o faturamento total da empresa em vendas?

**5.7** Quantas vendas foram realizadas no mês de junho de 2023?

**5.8** Qual vendedor realizou mais vendas (em quantidade de transações)?

**5.9** Qual vendedor gerou mais receita para a empresa?

---

## Nível 6: Operações de Atualização

A empresa está crescendo e mudanças precisam acontecer!

**6.1** Um novo departamento foi criado: **Inovações**. Ele será alocado no escritório "Wayne Offices". Adicione-o ao banco de dados.

**6.2** O departamento de Inovações está sem funcionários. Transfira 2 funcionários do departamento de Tecnologia para Inovações.

**6.3** A empresa decidiu dar um aumento de 10% para todos os funcionários do departamento de Tecnologia. Atualize os salários.

**6.4** O funcionário "Bruce Ernst" foi promovido a "Senior Web Developer" e recebeu um aumento para $5.000. Atualize suas informações.

**6.5** Adicione um novo suprimento ao escritório "Wayne Offices": 15 unidades de "Headsets" com preço unitário de $150 cada.

**6.6** Todos os funcionários contratados antes de 1990 estão aposentando. Remova-os do banco de dados (CUIDADO: execute um **SELECT** antes para ver quantos serão afetados!).

---

## Nível 7: Análise Avançada com Agregações

**7.1** Crie um relatório mostrando cada departamento com: nome do departamento, número de funcionários, salário total e média salarial.

**7.2** Liste os 3 cargos mais comuns na empresa e quantos funcionários ocupam cada cargo.

**7.3** Encontre todos os funcionários que ganham acima da média salarial de seus respectivos departamentos.

**7.4** Calcule a taxa de crescimento da empresa por ano (quantos funcionários foram contratados a cada ano).

**7.5** Crie um ranking dos vendedores, mostrando: nome do vendedor, número de vendas realizadas e receita total gerada.

**7.6** Encontre os produtos que foram vendidos por apenas um vendedor.

---

## Nível 8:  Auditoria de Vendas

O departamento financeiro suspeita de irregularidades.

**8.1** Encontre vendas que não possuem vendedor associado.

**8.2** Verifique se há vendedores registrados nas vendas que não existem na coleção de funcionários.

**8.3** Identifique produtos que aparecem nas vendas mas com preços unitários muito diferentes entre transações (variação > 10%).

**8.4** O CEO pediu um dashboard completo.

Crie UMA ÚNICA query de agregação que retorne:
   - Total de funcionários
   - Custo total com salários
   - Número de departamentos
   - Número de escritórios
   - Receita total de vendas
   - Produto mais vendido

## Nível 8: ETL do CSV

O arquivo [vendas_campanha_bruto.csv](vendas_campanha_bruto.csv) contém dados de pedidos e itens em formatos variados. 
O que você deve fazer: carregá-lo na tabela `stg_vendas_csv`, sem converter nem corrigir os valores na importação. 

**Dica**: No MySQL Workbench, vocês podem usar o **Table Data Import Wizard** apontando para a tabela já criada, com delimitador `;` e a primeira linha como cabeçalho. Se o ambiente permitir `LOAD DATA LOCAL INFILE`, também é possível usá-lo.

Construam um fluxo com estas fases:

1. **Extract:** importar todas as linhas e conservar `source_row_id` e `lote_origem`.
2. **Transform:** normalizar espaços e capitalização; converter quantidades, datas e preços; padronizar canal e status; conferir SKU e e-mail do vendedor; identificar duplicatas e conflitos.
3. **Load:** inserir pedidos em `vendas` e linhas em `itens_venda`. Registrar pendências ou rejeições em `etl_rejeicoes`, preservando o valor original, o campo e o motivo.

Regras para orientar a análise:

- usem `locale_origem` ao interpretar datas e separadores decimais; se a localidade não estiver identificada, não escolham uma interpretação por palpite;
- `moeda_raw` precisa ser identificável. Não convertam BRL ou outra moeda para USD sem uma taxa de câmbio aprovada;
- SKU desconhecido, vendedor sem correspondência, quantidade inválida, data impossível ou preço não interpretável precisam de tratamento documentado;
- linhas com a mesma combinação pedido/item podem ser duplicatas ou correções conflitantes. Compare os demais campos antes de decidir;
- se um pedido tiver uma linha pendente, decidam se carregam as linhas válidas ou mantêm o pedido inteiro em revisão. Registrem o critério usado;
- `source_row_id` em `itens_venda` liga uma linha carregada à linha original do CSV.

A tabela `etl_rejeicoes` foi criada para documentar decisões. Um registro rejeitado não deve desaparecer silenciosamente: indiquem se foi duplicata, rejeição definitiva ou revisão manual.

## Nível 9: Alterações seguras

Façam alterações em transações e verifiquem o resultado antes de confirmar:

- criar um departamento novo em um escritório existente;
- cadastrar o cargo “Senior Web Developer” e promover Bruce Ernst, atualizando cargo e salário;
- transferir duas pessoas de Tecnologia para o novo departamento, justificando a escolha;
- reajustar salários de quem permanecer em Tecnologia;
- adicionar uma compra de headsets com quantidade, custo unitário, moeda, data e referência de compra;
- simular aposentadoria alterando `situacao` para `INATIVO`, sem apagar o funcionário nem seu histórico.

Exemplo de fluxo seguro:

```sql
START TRANSACTION;
-- faça a alteração planejada
-- confira com SELECT se o resultado corresponde ao esperado
ROLLBACK; -- use COMMIT somente quando estiver validado
```
