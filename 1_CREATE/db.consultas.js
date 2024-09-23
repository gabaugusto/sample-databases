db.consultas.insertMany([
    {
        "data": ISODate("2018-06-25T10:00:00Z"),
        "medico_id": ObjectId("66e96ae976efecbc5e470c24"),
        "paciente_id": ObjectId("66e96b0576efecbc5e470c28"),
        "valor": 200,
        "conveniada": true,
        "especialidade_buscada": "Consulta Emergencial",
        "descricao": "Paciente com febre e tosse",
        "receita": {
            "medicamentos": [
                {
                    "nome": "Paracetamol Comprimidos",
                    "quantidade": 10,
                    "instrucoes": "Tomar 1 comprimido a cada 8 horas se dor ou febre"
                },
                {
                    "nome": "Ibuprofeno Comprimidos",
                    "quantidade": 12,
                    "instrucoes": "Tomar 1 comprimido a cada 12 horas"
                }
            ],
            "tratamentos": [
                {
                    "nome": "Inalação com soro fisiológico",
                    "frequencia": "2 vezes ao dia"
                }
            ]
        }
    },
    {
        "data": ISODate("2018-06-25T10:00:00Z"),
        "medico_id": ObjectId("66e96ae976efecbc5e470c24"),
        "paciente_id": ObjectId("66e96b0576efecbc5e470c29"),
        "valor": 150,
        "conveniada": true,
        "especialidade_buscada": "Consulta Emergencial",
        "descricao": "Paciente com cansaço e dor de cabeça",
        "receita": {
            "medicamentos": [
                {
                    "nome": "Diclofenaco Comprimidos",
                    "quantidade": 10,
                    "instrucoes": "Tomar 1 comprimido a cada 8 horas se dor ou febre"
                }
            ],
            "tratamentos": [
                {
                    "nome": "Repouso por 3 dias e terapia com soro fisiológico",
                }
            ]
        }
    },
    {
        "data": ISODate("2018-06-30T10:00:00Z"),
        "medico_id": ObjectId("66e96ae976efecbc5e470c25"),
        "paciente_id": ObjectId("66e96b0576efecbc5e470c28"),
        "valor": 218,
        "conveniada": false,
        "especialidade_buscada": "Consulta de Rotina",
        "descricao": "RETORNO. Paciente retorna com febre e tosse",
        "receita": {
            "medicamentos": [
                {
                    "nome": "Antibiótico Amoxicilina",
                    "quantidade": 10,
                    "instrucoes": "Tomar 1 comprimido a cada 8 horas se dor ou febre"
                }
            ],
            "tratamentos": [
                {
                    "nome": "Inalação com soro fisiológico",
                    "frequencia": "2 vezes ao dia"
                }, {
                    "nome": "Repouso por 7 dias e terapia com soro fisiológico",
                }
            ]
        }
    },
    {
        "data": ISODate("2018-06-25T10:00:00Z"),
        "medico_id": ObjectId("66e96ae976efecbc5e470c25"),
        "paciente_id": ObjectId("66e96b0576efecbc5e470c29"),
        "valor": 150,
        "conveniada": true,
        "especialidade_buscada": "Consulta de Rotina",
        "descricao": "Paciente com cansaço e dor de cabeça",
        "receita": {
            "medicamentos": [
                {
                    "nome": "Diclofenaco Comprimidos",
                    "quantidade": 10,
                    "instrucoes": "Tomar 1 comprimido a cada 8 horas se dor ou febre"
                }
            ],
            "tratamentos": [
                {
                    "nome": "Repouso por 3 dias e terapia com soro fisiológico",
                }
            ]
        },
    }, {
        "data": ISODate("2018-07-07T10:00:00Z"),
        "medico_id": ObjectId("66e96ae976efecbc5e470c26"),
        "paciente_id": ObjectId("66e96b0576efecbc5e470c29"),
        "valor": 218,
        "conveniada": false,
        "especialidade_buscada": "Consulta de Rotina",
        "descricao": "RETORNO. Paciente não apresenta mais sintomas",
        "receita": {
            "tratamentos": [
                {
                    "descrição": "Nenhum tratamento necessário. Liberado para volta ao trabalho."
                }
            ]
        }
    },
    {
        "data": ISODate("2018-06-25T10:00:00Z"),
        "medico_id": ObjectId("66e96ae976efecbc5e470c26"),
        "paciente_id": ObjectId("66e96b0576efecbc5e470c29"),
        "valor": 150,
        "conveniada": true,
        "especialidade_buscada": "Consulta de Rotina",
        "descricao": "Paciente com cansaço e dor de cabeça",
        "receita": {
            "medicamentos": [
                {
                    "nome": "Diclofenaco Comprimidos",
                    "quantidade": 10,
                    "instrucoes": "Tomar 1 comprimido a cada 8 horas se dor ou febre"
                }
            ],
            "tratamentos": [
                {
                    "nome": "Repouso por 3 dias e terapia com soro fisiológico",
                }
            ]
        }
    }
]);

// Consultar o valor da consulta do paciente Paulo Santos.
// Dessa vez, o valor da consulta é um campo do documento de consulta, e não do paciente.
// A expressão "valor": 1 no segundo argumento da função find() indica que apenas o campo "valor" deve ser retornado.
db.consultas.find({
    "paciente_id": ObjectId("66e96b0576efecbc5e470c28")
}, {
    "valor": 1
}).pretty();

// Consultar as somas dos valores das consultas de cada paciente.
// O método aggregate() é utilizado para realizar operações de agregação no MongoDB.
// A operação de agregação $group é utilizada para agrupar os documentos de uma coleção.
// A operação $sum é utilizada para somar os valores dos documentos agrupados.
db.consultas.aggregate([{
    $group: {
        _id: "$paciente_id",
        total: {
            $sum: "$valor"
        }
    }
}]);


// Consultar quais os filmes que ganharam o Oscar de Melhor Filme e Melhor Diretor na mesma cerimonia?
// Para isso, utilize o operador $match para filtrar os documentos em que os campos "awards.wins" e "awards.nominations" sejam maiores que 0.
// Em seguida, utilize o operador $project para projetar apenas os campos "title" e "awards".
// Por fim, utilize o operador $match novamente para filtrar os documentos em que "awards.wins" seja igual a 1 e "awards.nominations" seja igual a 2.
db.oscar.aggregate([
    {
        $match: {
            "awards.wins": { $gt: 0 },
            "awards.nominations": { $gt: 0 }
        }
    },
    {
        $project: {
            title: 1,
            awards: 1
        }
    },
    {
        $match: {
            "awards.wins": 1,
            "awards.nominations": 2
        }
    }
]);

