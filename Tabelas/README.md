# O Básico sobre Tabelas em SQL

## Introdução

Tabelas são estruturas de dados que armazenam informações de forma organizada. Em SQL, a linguagem de consulta estruturada, tabelas são utilizadas para armazenar dados de forma organizada e eficiente. Neste artigo, vamos aprender o básico sobre tabelas em SQL.

## O que é uma Tabela em SQL?

Uma tabela em SQL é uma estrutura de dados que armazena informações de forma organizada. Uma tabela é composta por colunas e linhas. Cada coluna representa um atributo da tabela, e cada linha representa um registro da tabela. Por exemplo, uma tabela de usuários pode ter as colunas `id`, `nome` e `email`, e cada linha da tabela pode representar um usuário com um `id`, `nome` e `email` específicos.

## Colunas e Tipos de Dados

Cada coluna de uma tabela em SQL tem um nome e um tipo de dado associado. O tipo de dado de uma coluna define o tipo de valor que pode ser armazenado nessa coluna. Alguns dos tipos de dados mais comuns em SQL são:

- `INT`: Números inteiros.
- `VARCHAR(n)`: Strings de até `n` caracteres.
- `DATE`: Datas.
- `BOOL`: Valores booleanos (verdadeiro ou falso).

Por exemplo, a coluna `id` de uma tabela de usuários pode ser do tipo `INT`, a coluna `nome` pode ser do tipo `VARCHAR(100)`, e a coluna `email` pode ser do tipo `VARCHAR(100)`.

## Criando um banco de dados

- Exemplo de como criar um banco
```sql	
CREATE database banco_de_dados_exemplo;
```	

ou 

```sql
CREATE DATABASE IF NOT EXISTS banco_de_dados_exemplo; 
```

-- Escolho o banco para trabalhar
USE banco_de_dados_exemplo;

## Criando uma Tabela

Para criar uma tabela em SQL, utilizamos a instrução `CREATE TABLE`. A sintaxe básica para criar uma tabela é a seguinte:

```sql
CREATE TABLE nome_da_tabela (
    nome_da_coluna1 tipo_de_dado1,
    nome_da_coluna2 tipo_de_dado2,
    ...
    nome_da_colunaN tipo_de_dadoN
);
```

Por exemplo, para criar uma tabela chamada `usuarios` com as colunas `id`, `nome` e `email`, podemos utilizar o seguinte comando:

```sql
CREATE TABLE usuarios (
    id INT,
    nome VARCHAR(100),
    email VARCHAR(100)
);
```

Alguns exemplos de regras/constraints:

- `PRIMARY KEY`: Torna o campo único e obrigatório. Só pode ser utilizado uma única vez por tabela. 
- `FOREIGN KEY`: Chave estrangeira, faz referência a uma chave primária de outra tabela.
- `AUTO_INCREMENT`: Incrementa automaticamente o valor do campo.
- `NOT NULL`: o campo não pode ser nulo, ou seja, o campo é obrigatório.
- `UNIQUE`: O campo não pode ter valores repetidos com outros registros.
- `DEFAULT`: Se o campo estiver vazio, será preenchido automaticamente com o valor informado.

## Inserindo Dados em uma Tabela

Para inserir dados em uma tabela em SQL, utilizamos a instrução `INSERT INTO`. A sintaxe básica para inserir dados em uma tabela é a seguinte:

```sql
INSERT INTO nome_da_tabela (nome_da_coluna1, nome_da_coluna2, ..., nome_da_colunaN)
VALUES (valor_da_coluna1, valor_da_coluna2, ..., valor_da_colunaN);
```

## Consultando Dados em uma Tabela

Para consultar dados em uma tabela em SQL, utilizamos a instrução `SELECT`. A sintaxe básica para consultar dados em uma tabela é a seguinte:

```sql
SELECT nome_da_coluna1, nome_da_coluna2, ..., nome_da_colunaN
FROM nome_da_tabela;
```

## Atualizando Dados em uma Tabela

Para atualizar dados em uma tabela em SQL, utilizamos a instrução `UPDATE`. A sintaxe básica para atualizar dados em uma tabela é a seguinte:

```sql
UPDATE nome_da_tabela
SET nome_da_coluna1 = valor_da_coluna1, nome_da_coluna2 = valor_da_coluna2, ..., nome_da_colunaN = valor_da_colunaN
WHERE condicao;
```

## Apagando Dados em uma Tabela

Para excluir dados em uma tabela em SQL, utilizamos a instrução `DELETE`. A sintaxe básica para excluir dados em uma tabela é a seguinte:

```sql
DELETE FROM nome_da_tabela
WHERE condicao;
```

## Conclusão

Neste artigo, aprendemos o básico sobre tabelas em SQL. Vimos como criar uma tabela, inserir dados em uma tabela e consultar dados em uma tabela. As tabelas são fundamentais em SQL e são utilizadas para armazenar dados de forma organizada e eficiente. Espero que este artigo tenha sido útil e que você tenha aprendido algo novo. 