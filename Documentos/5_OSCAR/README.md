# Nomeados ao Oscar

Contém a base de indicados ao Oscar em formato SQL para treinar comandos CRUD. 

Abaixo, algumas atividades para trabalharmos.

--- 

* Atualize os registros da tabela com os dados do Oscar 2025

---

* Qual o **total** de registros na tabela indicados?

---

* Qual o número de indicações por categoria agrupadas por categoria?

R: 2

Q:
```js
db.indicados_ao_oscar.aggregate([
  {
    $group: {
      _id: "$categoria",  
      total_indicacoes: { $sum: 1 }  
    }
  },
  {
    $sort: { total_indicacoes: -1 } 
  }
]);
```

---

* Quantas vezes Natalie Portman foi indicada ao Oscar?

R: 3 vezes

Q:
```js
 db.oscar.find({"Nome": "Natalie Portman"}).countDocuments()
```

---

* Quantos Oscars Natalie Portman ganhou?

---

* Quantas vezes Viola Davis foi indicada ao Oscar?

---

* Quantos Oscars Viola Davis ganhou?

---

* Amy Adams já ganhou algum Oscar?

---

* Quais os atores/atrizes que foram indicados mais de uma vez?

---

* A série de filmes Toy Story ganhou Oscars em quais anos?

---

* A partir de que ano que a categoria "Actress" deixa de existir? 

---

* Quem ganhou o primeiro Oscar para Melhor Atriz? Em que ano?

---

* Na campo "Vencedor", altere todos os valores com "true" para 1 e todos os valores "false" para 0.

---

* Em qual edição do Oscar "Crash" concorreu ao Oscar?

---

* O filme Central do Brasil aparece no Oscar?

---

* Inclua no banco 3 filmes que nunca foram nem nomeados ao Oscar, mas que merecem ser. 

---

* Denzel Washington já ganhou algum Oscar?

---

* Quais os filmes que ganharam o Oscar de Melhor Filme?

---

* Sidney Poitier foi o primeiro ator negro a ser indicado ao Oscar. Em que ano ele foi indicado? Por qual filme?

---

* Quais os filmes que ganharam o Oscar de Melhor Filme e Melhor Diretor na mesma cerimonia?

---

* Denzel Washington e Jamie Foxx já concorreram ao Oscar no mesmo ano?
