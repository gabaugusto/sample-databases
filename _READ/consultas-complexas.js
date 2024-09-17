

// Buscar todos os médicos que tenham "Infectologia" como especialidade e que tenham status 1 ou 2
db.medicos.find({
  especialidades: "Infectologia",
  status: {
    $in: [1, 2]
  }
});

// Buscar todos os médicos e ordernar por nome
db.medicos.find().sort({
  nome: 1
});

// Buscar todos os médicos e ordernar por nome de forma decrescente
db.medicos.find().sort({
  nome: -1
});

// Buscar todos os médicos e ordernar por nome e especialidade
db.medicos.find().sort({
  nome: 1,
  especialidades: 1
});

// Buscar  e ordernar por nome e especialidade e limitar a 5 registros
db.medicos.find().sort({
  nome: 1,
  especialidades: 1
}).limit(5);

// Buscar  e ordernar por nome e especialidade e limitar a 5 registros e pular 5 registros
db.medicos.find().sort({
  nome: 1,
  especialidades: 1
}).limit(5).skip(5);

// Buscar enfermeiros com altura maior que 1.70
db.enfermeiros.find({
  altura: {
    $gt: 1.70
  }
});

// Buscar enfermeiros que nasceram antes de 1995
db.enfermeiros.find({
  data_nascimento: {
    $lt: ISODate("1995-01-01")
  }
});

// Buscar e ordernar por data de nascimento dentro de um determinado intervalo
db.enfermeiros.find({
  data_nascimento: {
    $gte: ISODate("1990-01-01"),
    $lte: ISODate("1995-01-01")
  }
});

// Buscar uma consulta pelo id e encontrar o médico relacionado
db.consultas.aggregate([{
  $match: {
    _id: ObjectId("5f1d6a0c4e1f4d0b5c1e4d5b")
  }
}, {
  $lookup: {
    from: "medicos",
    localField: "medico",
    foreignField: "_id",
    as: "medico"
  }
}]);