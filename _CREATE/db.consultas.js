db.consultas.insertOne(
    {
        "data": ISODate("2018-06-25T10:00:00Z"),
        "medico_id": ObjectId("788b3b9b0b1e6b1f1c1f1c1f"),
        "paciente_id": ObjectId("5f8b3b9b0b1e6b1f1c1f1c1f"),
        "valor": 200,
        "conveniada": true,
        "especialidade_buscada": "Pediatria",
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