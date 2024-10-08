----------------------------------------------------
----------------------------------------------------
----------------------------------------------------
-- Bancos de Dados
-- Criação de um banco de dados

CREATE DATABASE nome_do_banco;

----------------------------------------------------
----------------------------------------------------
----------------------------------------------------
-- TABELAS

CREATE TABLE nome_da_tabela (
    nome_da_coluna tipo_da_coluna,
    nome_da_coluna tipo_da_coluna,
    nome_da_coluna tipo_da_coluna
);

-- ou 

CREATE TABLE medicos (
    crm int,
    nome varchar(125),
    email varchar(125),
    PRIMARY KEY (crm)
);

-- Criação de uma tabela com chave estrangeira

CREATE TABLE consultas (
    id int,
    descricao TEXT,
    datahora DATETIME,
    crm int,
    PRIMARY KEY (cpf),
    FOREIGN KEY (crm) REFERENCES medicos(crm)
);

----------------------------------------------------
----------------------------------------------------
----------------------------------------------------
-- REGISTROS

-- Inserindo registros em uma tabela

INSERT INTO nome_da_tabela (nome_da_coluna1, nome_da_coluna2, nome_da_coluna3)
VALUES (valor1, valor2, valor3);

-- ou

INSERT INTO medicos (crm, nome, email)
VALUES (123456, 'Dr. Fulano', 'fulano@hospital.com');