// alterar o nome de um único médico
db.medicos.updateOne({
    nome: "Dra. Carla Elizabete"
}, {
    $set: {
        nome: "Dra. Carla Bete"
    }
});

// alterar o nome de todos os médicos que tenham "Infectologia" como especialidade
db.medicos.updateMany({
    especialidades: "Infectologia"
}, {
    $set: {
        nome: "Dr(a). Infectologista"
    }
});