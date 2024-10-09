# Nomeados ao Oscar

Contém a base de indicados ao Oscar em formato JSON para treinar comandos de consulta no MongoDB. 

* Quantas vezes Natalie Portman foi indicada ao Oscar?

R: 3 vezes

Q:
```sql
SELECT COUNT(*) FROM indicados WHERE "Name" Like "%Natalie Portman%";
```

* Quantos Oscars Natalie Portman ganhou?

* Amy Adams já ganhou algum Oscar?

* A série de filmes Toy Story ganhou um Oscar em quais anos?

* A partir de que ano que a categoria "Actress" deixa de existir? 

* Quem ganhou o primeiro Oscar para Melhor Atriz? Em que ano?

* Na campo "Vencedor", altere todos os valores com "true" para 1 e todos os valores "false" para 0.

* Em qual edição do Oscar "Crash" concorreu ao Oscar?

* O filme Central do Brasil aparece no Oscar?

* Inclua no banco 3 filmes que nunca foram nem nomeados ao Oscar, mas que merecem ser. 

* Denzel Washington já ganhou algum Oscar?

* Quais os filmes que ganharam o Oscar de Melhor Filme?

* Bonus: Quais os filmes que ganharam o Oscar de Melhor Filme e Melhor Diretor na mesma cerimonia?

* Bonus: Denzel Washington e Jamie Foxx já concorreram ao Oscar no mesmo ano?
