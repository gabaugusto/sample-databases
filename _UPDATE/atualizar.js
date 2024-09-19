// Alterar o nome de um único médico
db.medicos.updateOne({
    nome: "Dra. Carla Elizabete"
}, {
    $set: {
        nome: "Dra. Carla Bete"
    }
});

// Alterar o nome de todos os médicos que tenham "Infectologia" como especialidade
db.medicos.updateMany({
    especialidades: "Infectologia"
}, {
    $set: {
        nome: "Dr(a). Infectologista"
    }
});

// Alterar o nome de todos os médicos que tenham o CRM como documentos.CRM e adicionando um novo campo
db.medicos.updateOne({
    "documentos.CRM": 'MG234567'
}, {
    $set: {
        nome: "Dra. Carla Bete",
        "documentos.Passaporte": 'A1B2C3D4E5F6',
    }
});

// Remover um campo é simples: basta usar o operador $unset
db.medicos.updateOne({
    nome: "Dra. Carla Bete"
}, {
    $unset: {
        "documentos.Passaporte": ""
    }
});