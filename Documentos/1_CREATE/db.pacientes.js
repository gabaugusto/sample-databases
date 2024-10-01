db.pacientes.insertMany([
    {
        "_id": ObjectId("66e96b0576efecbc5e470c28"),
        "nome": "Paulo Santos",
        "data_nascimento": ISODate("1995-02-14"),
        "altura": 1.75,
        "endereco": {
            "logradouro": "Rua A",
            "numero": "10",
            "bairro": "Centro",
            "cidade": "São Paulo",
            "estado": "SP",
            "CEP": "12345678"
        },
        "contato": {
            "telefone": "111122223333",
            "email": "paulo@gmail.com"
        },
        "convenio": {
            "nome": "Saúde Perfeita",
            "validade": ISODate("2021-12-31"),
            "CNPJ": "23456789000102",
            "carencia": 60
        },
        "documentos": {
            "CPF": "98765432100",
            "RG": "SP123456"
        }
    },
    {
        "_id": ObjectId("66e96b0576efecbc5e470c29"),
        "nome": "Maria Oliveira",
        "data_nascimento": ISODate("1987-11-30"),
        "altura": 1.55,
        "endereco": {
            "logradouro": "Rua B",
            "numero": "20",
            "bairro": "Vila Mariana",
            "cidade": "São Paulo",
            "estado": "SP",
            "CEP": "12345679"
        },
        "contato": {
            "telefone": "222233344444",
            "email": "maria@gmail.com"
        },
        "documentos": {
            "CPF": "87654321009",
            "RG": "SP123457"
        },
        "convenio": {
            "nome": "UniSaude",
            "validade": ISODate("2021-12-31"),
            "CNPJ": "12345678000101",
            "carencia": 30
        }
    }
]);
