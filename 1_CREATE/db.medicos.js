// insertMany - Adiciona vários documentos a uma coleção


db.medicos.insertMany([
    {
        "nome": "Dra. Ana Souza",
        "data_nascimento": ISODate("1985-02-10"),
        "especialidades": [
            "Dermatologia"
        ],
        "tipo": "Especialista",
        "contato": {
            "telefone": "222222222",
            "email": "ana@hospital.com"
        },
        "documentos": {
            "CPF": "23456789012",
            "CRM": "SP234567"
        },
        "status": 1
    }, {
        "nome": "Dr. Roberto Dias",
        "data_nascimento": ISODate("1990-11-05"),
        "especialidades": [
            "Clínica Geral",
            "Cardiologia"
        ],
        "tipo": "Residente",
        "contato": {
            "telefone": "444444444",
            "email": "roberto@hospital.com"
        },
        "status": 1,
        "documentos": {
            "CPF": "45678901234",
            "CRM": "RJ456789"
        }
    },{
        "nome": "Dr. João Silva",
        "data_nascimento": ISODate("1980-05-14"),
        "especialidades": [
            "Pediatria"
        ],
        "tipo": "Generalista",
        "contato": { 
            "telefone": "111111111",
            "email": "joao@hospital.com"
        },
        "status": 1,
        "documentos": { 
            "CPF": "12345678901", 
            "CRM": "MG123456"
        }
    },{
        "nome": "Dr. Carlos Pereira",
        "status": 0,
        "data_nascimento": ISODate("1975-08-22"),
        "especialidades": [
            "Gastroenterologia"
        ],
        "tipo": "Especialista",
        "contato": {
            "telefone": "333333333",
            "email": "carlos@hospital.com"
        },
        "documentos": {
            "CPF": "34567890123",
            "CRM": "MA345678"
        }
    }
])