# O Básico de documentos no MongoDB. 

Este é um manual básico sobre MongoDB, um banco de dados NoSQL orientado a documentos.

## O que é um banco de dados NoSQL?

NoSQL é um termo genérico que se refere a bancos de dados não relacionais. Diferentemente dos bancos de dados relacionais, os bancos de dados NoSQL não utilizam o SQL como linguagem de consulta.

## O que é MongoDB?

MongoDB é um banco de dados NoSQL orientado a documentos, desenvolvido pela empresa 10gen. Ele é um banco de dados de código aberto, escrito em C++.

## O que é um banco de dados orientado a documentos?

Um banco de dados orientado a documentos é um tipo de banco de dados NoSQL que armazena os dados em documentos. Cada documento é um objeto JSON que contém os dados e os metadados associados a esses dados.

## Exemplos de Documentos BSON

O MongoDB armazena os documentos em um formato binário chamado BSON (Binary JSON). O BSON é uma extensão do JSON que adiciona tipos de dados adicionais, como `Date`, `Binary`, `ObjectId`, entre outros.

### Exemplo de documento JSON:

```json
{
  "nome": "Cristina Fernanda",
  "idade": 30,
  "email": "a@b.com"
}

```

### Exemplo de documento BSON:
  
```json
{
  "nome": "Cristina Fernanda",
  "data_nascimento": ISODate("1990-01-01T00:00:00Z"),
  "_id": ObjectId("5f8b8eae3b4d4b001f6f7b3d")
}
```

