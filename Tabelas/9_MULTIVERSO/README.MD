# Desafio: Inventário em crise na Loja Portal 9

## Contexto

A **Loja Portal 9** vende colecionáveis de diferentes franquias. Às vésperas da **Feira Multiverso**, a equipe percebeu que o catálogo foi montado a partir de planilhas e exportações de fornecedores. O mesmo item pode aparecer mais de uma vez; alguns registros discordam sobre **preço, variante ou estoque**; e valores importantes vieram **incompletos ou em formatos diferentes**.

A feira começa em breve. A equipe precisa decidir **quais produtos podem ser anunciados**, **quais dados precisam de confirmação** e **quais registros devem ficar em análise**. Sua missão é preparar uma **base confiável** para essas decisões e explicar como chegou a cada tratamento.

## O que você vai fazer

### 1. Investigar a base bruta

Importe o arquivo [portal9_catalogo_bruto.sql](portal9_catalogo_bruto.sql) em um banco **MySQL**. A tabela de origem preserva os valores como chegaram, inclusive diferenças de escrita e registros que podem parecer duplicados.

Antes de alterar os dados:

- identifique problemas de **tipos de dados, preenchimento, formato, domínio e consistência**;
- compare registros com o mesmo SKU e produtos que parecem iguais, **sem presumir que sejam duplicatas**;
- diferencie **ausência de informação, valor desconhecido, zero e valor inválido**;
- registre quais casos podem ser **corrigidos com segurança** e quais precisam de **confirmação**.

### 2. Definir regras de qualidade

Em grupo, criem um **pequeno protocolo de tratamento**. Para cada tipo de problema, indiquem:

- a **regra aplicada**;
- quando o dado deve ser **corrigido, mantido, separado ou marcado para revisão**;
- como **preservar o valor original** e rastrear a origem da decisão.

**Não inventem valores para completar lacunas.** Se um preço não tiver moeda identificável, ou uma data não permitir determinar o dia, **sinalizem essa limitação** em vez de supor uma resposta. Você pode criar uma tabela de referência para **moedas, datas e variantes** que ajude a equipe a decidir se um registro pode ser anunciado ou precisa de confirmação.

### 3. Criar uma versão tratada

Criem uma **tabela de trabalho limpa**, mantendo uma referência ao registro bruto. Padronizem campos e tipos **apenas quando houver informação suficiente**. Valores não resolvidos devem continuar rastreáveis e distinguíveis de um zero ou de um campo vazio.

A equipe deve conseguir explicar por que dois registros foram **unidos ou mantidos separados**. **SKU repetido, nome parecido ou mesma franquia, isoladamente, não provam** que dois registros representam o mesmo produto.

### 4. Propor um modelo relacional

A partir da análise, proponham um **modelo normalizado até a 3ª Forma Normal**. Considerem quais informações pertencem a entidades distintas, como:

- **produtos e suas variantes**;
- **franquias e categorias**;
- **fornecedores**;
- **observações de preço e estoque** vindas de cada lote de importação.

Escolham **chaves primárias e estrangeiras**, definam restrições que façam sentido e expliquem como o modelo evita inconsistências. O modelo pode variar entre equipes, desde que as decisões sejam **justificadas**.

### 5. Apoiar uma decisão da loja

Escrevam **consultas SQL** para responder perguntas úteis à equipe da Feira Multiverso. Por exemplo:

- Quais registros podem ser **anunciados agora** e quais estão bloqueados para revisão?
- Que SKUs aparecem com **descrições, variantes ou fornecedores divergentes**?
- Quais produtos estão **sem estoque, com estoque suspeito ou com quantidade desconhecida**?
- Como comparar preços **sem misturar moedas** ou transformar valores sem uma cotação definida?
- Quais franquias e categorias concentram mais **itens disponíveis**?

Reconstruam uma visão integrada com `JOIN`. Se fizer sentido, criem uma **view para a equipe de catálogo**.

### 6. Novos dados, novos problemas

Chegou uma nova remessa de dados, com **mais registros e mais divergências**. A equipe precisa **repetir o processo de investigação e tratamento** para manter a base confiável e importa apenas os registros que podem ser anunciados. 

A nova remessa chama [nerd_itens_old_bases.sql](nerd_itens_old_bases.sql)

## Entregas

1. **Diagnóstico das anomalias** encontradas e protocolo de tratamento.
2. **Script SQL** com o modelo normalizado, as tabelas preenchidas e as consultas de decisão.
3. **Versão tratada** que mantenha a rastreabilidade até os registros de origem.
4. **Breve justificativa dos casos ambíguos**: o que foi decidido e o que ficou pendente de confirmação.

## Critérios de sucesso

- Os **valores originais continuam consultáveis**.
- As regras são **consistentes e explicitadas**, sem correções por palpite.
- **Duplicatas reais são tratadas** sem apagar variantes ou históricos legítimos.
- O modelo separa entidades e fatos que têm **ciclos de vida diferentes**.
- As consultas ajudam alguém da loja a tomar uma **decisão concreta**.

## O que é Normalização de Banco de Dados?

A **normalização** é um processo de organização de dados em um banco de dados relacional. O objetivo é reduzir a redundância e melhorar a integridade dos dados, dividindo os dados em tabelas menores e definindo relacionamentos entre elas. A normalização geralmente envolve várias etapas, conhecidas como **formas normais**, que incluem:

- **1ª Forma Normal (1NF)**: Elimina grupos repetitivos e garante que cada campo contenha apenas valores atômicos.
- **2ª Forma Normal (2NF)**: Remove dependências parciais, garantindo que cada campo não-chave dependa da chave primária inteira.
- **3ª Forma Normal (3NF)**: Remove dependências transitivas, garantindo que os campos não-chave dependam apenas da chave primária.

## O que é Higienização de Dados?

A **higienização de dados** é o processo de identificar e corrigir ou remover dados incorretos, incompletos, duplicados ou irrelevantes de um conjunto de dados. O objetivo é melhorar a qualidade dos dados, tornando-os mais precisos, consistentes e confiáveis para análise e tomada de decisões. A higienização de dados pode envolver várias etapas, incluindo:

- **Detecção de erros**: Identificar dados incorretos, inconsistentes ou incompletos.
- **Correção de erros**: Corrigir ou remover dados incorretos, inconsistentes ou incompletos.

## Dica

Funções como `TRIM`, `LOWER`, `UPPER`, `REPLACE`, `CASE`, `CAST` e `STR_TO_DATE` podem ajudar. Use-as **depois de compreender os formatos e as ambiguidades** dos dados. 

**Importante**: Uma conversão que roda sem erro ainda pode produzir um resultado errado.
