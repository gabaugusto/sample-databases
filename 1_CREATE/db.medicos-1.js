// insertOne é um método que insere um único documento em uma coleção.

// O método insertOne() recebe um documento como argumento e o insere na coleção especificada. Se o documento não contiver um campo _id, o MongoDB adicionará um campo _id com um ObjectId gerado automaticamente.

// ISODate é um método que cria um novo objeto Date a partir de uma string no formato ISO 8601.
// O registro do campo com ISODate seguirá o seguinte padrão:
// {
//     "campo": ISODate("YYYY-MM-DD")
// }

db.medicos.insertOne(
    {
        "nome": "Dra. Carla Elizabete",
        "data_nascimento": ISODate("1989-06-29"),
        "especialidades": [
            "Infectologia",
        ],
        "tipo": "Especialista",
        "contato": {
            "telefone": "55-11-98765-4321",
            "email": "carla.bete@hospital.com"
        },
        "documentos": {
            "CPF": "23456789012",
            "CRM": "MG234567"
        },
        "status": 1
    }
)