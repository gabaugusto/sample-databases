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
        "_id": ObjectId("66e96b2076efecbc5e470c2a"),
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

