// Buscar todas os médicos
db.medicos.find();

// Busca todos os médicos com o CRM MG234567
db.medicos.find({
  "documentos.CRM": "MG234567"
});

// Buscar médicos por nome 
db.medicos.find({
  nome: "Dra. Carla Elizabete"
});

// Buscar todos os médicos por parte do nome
db.medicos.find({
  nome: /Carla/
});

// Buscar todos os médicos que tenham "Infectologia" como especialidade
db.medicos.find({
  especialidades: "Infectologia"
});

// Buscar todos os médicos que tenham "Infectologia" como especialidade e que tenham status 1
db.medicos.find({
  especialidades: "Infectologia",
  status: 1
});