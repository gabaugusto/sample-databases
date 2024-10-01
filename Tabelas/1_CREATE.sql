-- Comandos Básicos de Criação 

-- Criação de um banco de dados

CREATE DATABASE nome_do_banco;

-- Criação de uma tabela

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