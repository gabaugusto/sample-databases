db.internacoes.insertMany([
    {
        "paciente_id": ObjectId("788b3b9b0b1e6b1f1c1f1c1f"),
        "medico_responsavel_id": ObjectId("5f8b3b9bew36b1f1c1f1caa"),
        "data_entrada": ISODate("2021-04-10T08:00:00Z"),
        "data_prevista_alta": ISODate("2021-04-15T10:00:00Z"),
        "data_efetiva_alta": ISODate("2021-04-14T12:00:00Z"),
        "procedimentos": [
            "Cirurgia",
            "Exame de sangue"
        ],
        "quarto_id": ObjectId(""),
        "enfermeiros_responsaveis": [ObjectId("")
        ]
    },
    {
        "paciente_id": ObjectId("8a24h1b5d9931b5b00ajhs3b"),
        "medico_responsavel_id": ObjectId("5f8b3b9bew36b1f1c1f1caa"),
        "data_entrada": ISODate("2021-04-10T08:00:00Z"),
        "data_prevista_alta": ISODate("2021-04-15T10:00:00Z"),
        "data_efetiva_alta": ISODate("2021-04-14T12:00:00Z"),
        "procedimentos": [
            "Cirurgia",
            "Exame de sangue"
        ],
        "quarto_id": ObjectId(""),
        "enfermeiros_responsaveis": [ObjectId(""), ObjectId("")
        ]
    }
]);
  