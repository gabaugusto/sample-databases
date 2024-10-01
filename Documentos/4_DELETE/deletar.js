// Apagar um registro do banco de dados é uma operação que deve ser feita com cuidado, pois não é possível desfazê-la. Para apagar um registro, utilizamos o método deleteOne() ou deleteMany(), que funcionam de forma similar aos métodos updateOne() e updateMany(), respectivamente.

// Para apagar um registro, passamos um objeto de filtro como primeiro argumento, que indica qual registro deve ser apagado. O segundo argumento é um objeto de opções, que pode ser omitido. Veja um exemplo de uso do método deleteOne():

db.medicos.deleteOne({
    nome: "Dr. Carlos Pereira"
});

// No exemplo acima, estamos apagando o registro do médico Dr. Carlos Pereira. Se quisermos apagar mais de um registro, podemos utilizar o método deleteMany(). Veja um exemplo:

db.medicos.deleteMany({
    status: 0
});

// No exemplo acima, estamos apagando todos os registros de médicos que estão com status 0. Note que, assim como no método updateMany(), o método deleteMany() apaga todos os registros que correspondem ao filtro passado como argumento.

// Para apagar todos os registros de uma coleção, podemos utilizar o método drop():

db.medicos.drop();

// O método drop() apaga todos os registros de uma coleção, mas mantém a coleção em si. Se quisermos apagar a coleção inteira, incluindo a coleção em si, podemos utilizar o método dropDatabase():

db.dropDatabase();

// O método dropDatabase() apaga a base de dados inteira, incluindo todas as coleções que ela contém. Tome cuidado ao utilizar este método, pois ele não pode ser desfeito.