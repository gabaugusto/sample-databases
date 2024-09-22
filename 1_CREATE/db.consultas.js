db.consultas.insertOne(
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
                    "nome": "Paracetamol comprimidos",
                    "quantidade": 10,
                    "instrucoes": "Tomar 1 comprimido a cada 8 horas"
                },
                {
                    "nome": "Ibuprofeno comprimidos",
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
    }
);