# Momento 

Você está prestes a explorar o banco de dados da empresa "Momento"! Com essa base de dados, vamos treinar consultas MongoDB Compass e responder algumas perguntas intrigantes que vão revelar como a empresa está organizada. Vamos lá?

### Departamento de Tecnologia 

* Inclua suas próprias informações no departamento de Tecnologia da empresa.
Resposta: 

```bson
insertOne({
  "nome": "Ana",
  "sobrenome": "Silva",
  "data_nascimento": "1990-01-01",
  "data_contratacao": "2020-01-01",
  "salario": 5000,
  "departamento": "Tecnologia",
  "cargo": "Desenvolvedora",
  "escritorio": "São Paulo"
})
```

* Agora diga, quantos funcionários temos ao total na empresa?

* E quanto ao Departamento de Tecnologia?

### Departamento de Vendas 

* **Quantos funcionários trabalham no Departamento de Vendas?**
Use uma consulta para descobrir o número total de funcionários alocados nesse departamento.

#### **Salários no Departamento de Vendas**

* Qual é o custo total dos salários do pessoal de Vendas? Isso nos ajuda a entender o orçamento do departamento!

* Quanto o departamento de Vendas gasta em salários?

Resposta:

```bson
db.funcionarios.aggregate([
  {
    $match: {
      departamento: "Vendas"
    }
  },
  {
    $group: {
      _id: null,
      total_salarios: {
        $sum: "$salario"
      }
    }
  }
])
```

* Quais são os produtos mais vendidos e quais têm pouca ou nenhuma saída?

* Qual é o produto mais caro no inventário da empresa?

### Departamento de Inovações 

* **Um novo departamento foi criado. O departamento de Inovações.** 
Ele será locado no Brasil. Por favor, adicione-o no banco de dados da empresa colocando quaisquer informações que você achar relevantes.

* O departamento de Inovações está sem funcionários. Inclua alguns colegas de turma nesse departamento.  

### Funcionários

* Quantos funcionários da empresa Momento possuem conjuges?

* Qual o funcionário contratado há mais tempo na empresa?

Resposta

```bson
db.funcionarios.find().sort({data_contratacao: 1}).limit(1)
```

* Qual o funcionário contratado há menos tempo na empresa?

* Quem são os funcionários com mais tempo na empresa, considerando a `data_contratacao`?

* Como a média salarial dos funcionários da "Momento" evoluiu nos últimos anos?
Dica: no MongoDB, utilize a função `$avg` para calcular a média salarial dos funcionários. e `$group` ou `$aggregate` para agrupar os resultados por ano.

* Qual a média salarial dos funcionários da empresa Momento, excluindo-se o CEO, CMO e CFO?

Resposta:

```bson
db.funcionarios.aggregate([
  {
    $match: {
      cargo: {
        $nin: ["CEO", "CMO", "CFO"]
      }
    }
  },
  {
    $group: {
      _id: null,
      media_salarial: {
        $avg: "$salario"
      }
    }
  }
])
```

* Qual a média salarial do departamento de tecnologia? 

* Qual o departamento com a maior média salarial?

* Qual o departamento com o menor número de funcionários?

### Produtos

* Pensando na relação quantidade e valor unitario, qual o produto mais valioso da empresa?

* Qual o produto mais vendido da empresa?

* Qual o produto menos vendido da empresa?

### Escritórios

* Quantos escritórios a "Momento" possui em cada região? (Dica: relacione as tabelas regioes e escritorios).

* Qual é o custo total de suprimentos em cada escritório? Que tal ordenar os resultados para ver qual escritório possui os suprimentos mais caros?
