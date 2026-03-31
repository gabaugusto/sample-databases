# Hotel Nebula 

A rede de Hotel Nebula está expandindo suas operações e precisa organizar digitalmente seus dados para melhorar reservas, hospedagens, serviços, avaliações de clientes e gestão dos quartos. A empresa quer desenvolver, no futuro, uma API de gestão hoteleira, mas antes disso precisa estruturar corretamente os dados.

### Objetivo geral

Desenvolver um projeto de banco de dados que percorra as etapas de:

- compreensão do problema
- modelagem dos dados
- implementação do banco
- extração e organização de dados

--- 

Crie um repositório no GitHub para o projeto e organize as entregas em três partes:

## Parte 1: Origem do Sistema

Em algum ponto entre a tecnologia, a organização e o caos elegante de um sistema mal planejado, existe o Hotel Nebula.

À primeira vista, ele parece apenas um hotel moderno: quartos confortáveis, reservas acontecendo a todo instante, hóspedes chegando de diferentes lugares, profissionais cuidando da operação, serviços extras sendo solicitados e avaliações aparecendo a cada nova estadia. Mas, por trás da recepção iluminada e das portas automáticas, existe um universo inteiro de dados tentando se organizar.

O problema é que esse universo ainda está disperso. O hotel tem informações sobre seus hóspedes, quartos, reservas, hospedagens, pagamentos, profissionais e avaliações, mas tudo isso está em sistemas diferentes, planilhas soltas ou até mesmo em papéis amassados. A equipe de gestão sabe que precisa colocar ordem nesse caos para melhorar a experiência dos clientes e otimizar a operação, mas não sabe por onde começar.

### Regras gerais do projeto

O sistema do hotel deve contemplar, no mínimo, elementos como:

- hóspedes
- quartos
- reservas
- hospedagens
- pagamentos
- profissionais/funcionários
- avaliações/comentários dos clientes

O que deve ser feito: 

- identificar os núcleos principais de informação
- definir coleções
- pensar em documentos embutidos e referências
- decidir quais dados fazem sentido agrupar
- desenhar a estrutura inicial do banco não relacional

Questões importantes
- uma reserva deve guardar dados do hóspede embutidos ou referenciados?
- avaliações ficam dentro do documento do quarto ou em coleção própria?
- serviços consumidos ficam dentro da hospedagem?
- como representar histórico sem perder flexibilidade?

### Entregáveis:

- estrutura do banco não relacional
- descrição das coleções e documentos
- descrição da proposta de modelagem
- justificativa das escolhas
- esquema inicial das coleções
- exemplo de documentos JSON

## Parte 2: Montagem do Núcleo

Foco: implementação física do banco relacional

O profissional agora precisa materializar a estrutura no banco não estruturado.

O que deve ser feito: 
- criar as coleções
- inserir documentos coerentes
- testar diferentes formatos de registro
- trabalhar dados aninhados
- pensar em escalabilidade e flexibilidade

Exemplos de coleções: 
- hospedes
- quartos
- reservas
- hospedagens
- feedbacks
- servicos
- pagamentos

O que observar: 
- documentos bem organizados
- uso intencional de arrays e subdocumentos
- consistência mínima entre registros
- capacidade de representar dados variáveis sem quebrar a estrutura

Entregáveis:
- script de inserção ou coleção exportada
- conjunto de documentos de exemplo
- explicação da arquitetura adotada

## Parte 3: Radar de Comando

Foco: consultas e extração de dados

O hotel agora quer enxergar melhor sua operação. O profissional deve produzir consultas que gerem informações relevantes para gestão.

O que deve ser feito

Criar consultas que respondam perguntas como:

- quais quartos possuem determinadas características? (Exemplo: "vista para o mar", "banheira", "luxo", etc.)
- quais hóspedes reservaram mais de uma vez?
- quanto o hotel faturou em um período? Exemplo: "faturamento em abril", "faturamento anual", etc.
- quais períodos têm mais ocupação? Exemplo: "quais meses têm mais reservas?", "quais dias da semana são mais movimentados?", etc.