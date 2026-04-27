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


// Ordenação 
// "Sort" serve para ordenar esses resultados. "1" É para ordem crescente e "-1" para ordem descrescente.  
db.medicos.find().sort({
  especialidades: -1
});

// "Limit" que limita a quantidade de resultados. Serve para não onerar o banco e ser mais assertivo. 
db.medicos.find().sort({
  especialidades: -1
}).limit(3);

// "Skip". Pula a quantidade de registros antes de trazer o resultado final. 
db.medicos.find().sort({
  especialidades: -1
}).limit(3).skip(5);