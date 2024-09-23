# Nomeados ao Oscar

Contém a base de indicados ao Oscar em formato JSON para treinar comandos de consulta no MongoDB. 

1- Quantas vezes Natalie Portman foi indicada ao Oscar?
R: 3 vezes
Q: db.oscar.find({"Nome": "Natalie Portman"}).countDocuments()

2- Quantos Oscars Natalie Portman ganhou?

3- Amy Adams já ganhou algum Oscar?

4- A série de filmes Toy Story ganhou um Oscar em quais anos?

5- A partir de que ano que a categoria "Actress" deixa de existir? 

6- Quem ganhou o primeiro Oscar para Melhor Atriz? Em que ano?

7- Na campo "Vencedor", altere todos os valores com "true" para 1 e todos os valores "false" para 0.

8- Em qual edição do Oscar "Crash" concorreu ao Oscar?

9- O filme Central do Brasil aparece no Oscar?

10- Inclua no banco 3 filmes que nunca foram nem nomeados ao Oscar, mas que merecem ser. 

11- Denzel Washington já ganhou algum Oscar?

12- Quais os filmes que ganharam o Oscar de Melhor Filme?

13- Bonus: Quais os filmes que ganharam o Oscar de Melhor Filme e Melhor Diretor na mesma cerimonia?

14- Bonus: Denzel Washington e Jamie Foxx já concorreram ao Oscar no mesmo ano?
