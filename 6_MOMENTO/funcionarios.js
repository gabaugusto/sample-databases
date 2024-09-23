db.funcionarios.insertMany(
    [
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e42"),
            "nome": "Elisabeth Braddock",
            "telefone": "515.123.5555",
            "email": "e.braddock@momento.org",
            "dataAdmissao": "1996-02-17",
            "cargo": "CEO",
            "salario": 71000,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe70"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e43"),
            "nome": "Pat Ferreira",
            "telefone": "603.123.6666",
            "email": "p.ferreira@momento.org",
            "dataAdmissao": "1997-08-17",
            "cargo": "Representante de Vendas para a América Latina",
            "salario": 34000,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
            "dependentes": {
                "filhos": [
                    {
                        "nome": "João Ferreira",
                        "dataNascimento": "2000-01-01",
                        "documento": "123.456.789-00"
                    },
                    {
                        "nome": "Maria Ferreira",
                        "dataNascimento": "2002-02-02",
                        "documento": "123.456.789-01"
                    }
                ],
                "conjuge": {
                    "nome": "Ana Ferreira",
                    "dataNascimento": "1975-03-03",
                    "documento": "123.456.789-02"
                }
            }
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e44"),
            "nome": "Alexander Hunold",
            "telefone": "590.423.4567",
            "email": "a.hunold@momento.org",
            "dataAdmissao": "2008-01-03",
            "cargo": "Web Developer",
            "salario": 3500,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe74"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e45"),
            "nome": "Bruce Ernst",
            "telefone": "590.423.4568",
            "email": "b.ernst@momento.org",
            "dataAdmissao": "2005-05-21",
            "cargo": "Web Developer",
            "salario": 3400,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe74"),
            "dependentes": {
                'filhos': [
                    {
                        'nome': "Bruce Ernst Jr.",
                        'dataNascimento': "2000-01-01",
                        'documento': "123.456.789-00"
                    }
                ],
            }
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e46"),
            "nome": "David Austin",
            "telefone": "590.423.4569",
            "email": "d.austin@momento.org",
            "dataAdmissao": "2000-06-25",
            "cargo": "Web Developer",
            "salario": 4100,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe74"),
            "dependentes": {
                "conjuge": {
                    "nome": "Mary Austin",
                    "dataNascimento": "1975-03-03",
                    "documento": "123.456.789-02"
                }
            }
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e47"),
            "nome": "Valli Stark",
            "telefone": "590.423.4560",
            "email": "v.stark@momento.org",
            "dataAdmissao": "2009-02-05",
            "salario": 2900,
            "cargo": "Web Developer",
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe74"),
            "dependentes": {
                "filhos": [
                    {
                        "nome": "Tony Stark",
                        "dataNascimento": "2000-01-01",
                        "documento": "123.456.789-00"
                    }
                ],
                "conjuge": {
                    "nome": "Pepper Potts",
                    "dataNascimento": "1975-03-03",
                    "documento": "123.456.789-02"
                }
            }
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e48"),
            "nome": "Diana Lorentz",
            "telefone": "590.423.5567",
            "email": "d.lorentz@momento.org",
            "dataAdmissao": "1999-02-07",
            "cargo": "Web Developer Senior",
            "salario": 8900,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe74"),
            "dependentes": {
                "filhos": [
                    {
                        "nome": "Diana Lorentz Jr.",
                        "dataNascimento": "2000-01-01",
                        "documento": "123.456.789-00"
                    }
                ],
                "conjuge": {
                    "nome": "Steve Rogers",
                    "dataNascimento": "1975-03-03",
                    "documento": "123.456.789-02"
                }
            }
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e49"),
            "nome": "Matthew Weiss",
            "telefone": "650.123.1234",
            "email": "m.weiss@momento.org",
            "dataAdmissao": "1996-07-18",
            "cargo": "Gerente de Estoque",
            "salario": 14000,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe75"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4a"),
            "nome": "Adam Fripp",
            "telefone": "650.123.2234",
            "email": "a.fripp@momento.org",
            "dataAdmissao": "1997-04-10",
            "cargo": "Gerente de Estoque",
            "salario": 9800,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe75"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4b"),
            "nome": "Payam Kaufling",
            "telefone": "650.123.3234",
            "email": "payam.kaufling@momento.org",
            "dataAdmissao": "1995-05-01",
            "cargo": "Vendas",
            "salario": 9600,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4c"),
            "nome": "Shanta Vollman",
            "telefone": "650.123.4234",
            "email": "shanta.vollman@momento.org",
            "dataAdmissao": "1997-10-10",
            "cargo": "Gerente de Estoque",
            "salario": 9700,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe75"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4d"),
            "nome": "Irene Adler",
            "telefone": "650.124.1224",
            "email": "irene.adler@momento.org",
            "dataAdmissao": "1980-09-28",
            "cargo": "Gerente de Estoque",
            "salario": 9700,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe75"),
            "dependentes": {
                "filhos": [
                    {
                        "nome": "Lara Pulver",
                        "dataNascimento": "2000-01-01",
                        "documento": "123.456.789-00"
                    }
                ],
                "conjuge": {
                    "nome": "S. Holme",
                    "dataNascimento": "1975-03-03",
                    "documento": "123.456.789-02"
                }
            }
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4e"),
            "nome": "Sarah Bell",
            "telefone": "650.501.1876",
            "email": "sarah.bell@momento.org",
            "dataAdmissao": "1996-02-04",
            "cargo": "Consultor de Vendas",
            "salario": 7900,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
            "dependentes": {
                "filhos": [
                    {
                        "nome": "John Bell",
                        "dataNascimento": "2000-01-01",
                        "documento": "123.456.789-00"
                    }
                ],
                "conjuge": {
                    "nome": "J. Bell",
                    "dataNascimento": "1975-03-03",
                    "documento": "123.456.789-02"
                }
            }
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4f"),
            "nome": "Britney Everett",
            "telefone": "650.501.2876",
            "email": "britney.everett@momento.org",
            "dataAdmissao": "1997-03-03",
            "cargo": "Consultor de Vendas",
            "salario": 7600,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e50"),
            "nome": "Jennifer Whalen",
            "telefone": "515.123.4444",
            "email": "jennifeer.whalen@momento.org",
            "dataAdmissao": "1987-09-17",
            "cargo": "Assistente Administrativo",
            "salario": 23000,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe75"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e51"),
            "nome": "Den Raphaely",
            "telefone": "515.127.4561",
            "email": "den.raphaely@momento.org",
            "dataAdmissao": "1994-12-07",
            "cargo": "Gerente de Recursos",
            "salario": 12500,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe75"),
        },
        {
            "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e52"),
            "nome": "Normam Osborn",
            "telefone": "515.127.4562",
            "email": "normam.osborn@momento.org",
            "dataAdmissao": "1995-05-18",
            "cargo": "Gerente de Recursos Químicos",
            "salario": 18080,
            "departamento": ObjectId("85992103f9b3e0b3b3c1fe75"),
            "dependentes": {
                "filhos": [
                    {
                        "nome": "Harry Osborn",
                        "dataNascimento": "2000-01-01",
                        "documento": "123.456.789-00"
                    }
                ],
                "conjuge": {
                    "nome": "Mary Jane Watson",
                    "dataNascimento": "1975-03-03",
                    "documento": "123.456.789-02"
                }
            }
        },
    {
        "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e53"),
        "nome": "Alexa Green",
        "telefone": "515.127.4563",
        "cargo": "Consultor de Vendas",
        "salario": 6000,
        "comissionado": true,
        "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
    },
    {
        "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e54"),
        "nome": "Kelly Chung",
        "telefone": "515.127.4564",
        "cargo": "Consultor de Vendas",
        "salario": 6000,
        "comissionado": true,
        "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
    },
    {
        "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e55"),
        "nome": "Jenny Tseng",
        "telefone": "515.127.4565",
        "cargo": "Consultor de Vendas",
        "salario": 6000,
        "comissionado": true,
        "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
    },
    {
        "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e56"),
        "nome": "Michael Hartstein",
        "telefone": "515.127.4566",
        "cargo": "Consultor de Vendas",
        "salario": 6000,
        "comissionado": true,
        "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
    },
    {
        "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e57"),
        "nome": "Jon Deegan",
        "telefone": "515.127.4567",
        "cargo": "Consultor de Vendas",
        "salario": 6000,
        "comissionado": true,
        "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
    },
    {
        "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e58"),
        "nome": "Sundar Ande",
        "telefone": "515.127.4568",
        "cargo": "Consultor de Vendas",
        "salario": 6000,
        "comissionado": true,
        "departamento": ObjectId("85992103f9b3e0b3b3c1fe71"),
    }]);