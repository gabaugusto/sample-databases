# Hotel Nebula — Modelo Lógico (Incompleto)

> Este modelo é um ponto de partida. Algumas tabelas estão incompletas, colunas estão faltando e relacionamentos precisam ser identificados e implementados pelos alunos.

---

## Tabelas

### hospedes
| Coluna           | Tipo           | Restrições        |
|------------------|----------------|-------------------|
| id_hospede       | INT            | PK, AUTO_INCREMENT |
| nome             | VARCHAR(100)   | NOT NULL          |
| email            | VARCHAR(100)   | UNIQUE, NOT NULL  |
| cpf              | VARCHAR(14)    | UNIQUE            |
| telefone         | VARCHAR(20)    |                   |
| data_nascimento  | DATE           |                   |
| -- ?             | --             | -- adicionar mais |

---

### quartos
| Coluna       | Tipo           | Restrições         |
|--------------|----------------|--------------------|
| id_quarto    | INT            | PK, AUTO_INCREMENT |
| numero       | VARCHAR(10)    | UNIQUE, NOT NULL   |
| tipo         | VARCHAR(50)    | NOT NULL           |
| capacidade   | INT            |                    |
| preco_diaria | DECIMAL(10,2)  | NOT NULL           |
| status       | VARCHAR(20)    |                    |
| -- ?         | --             | -- adicionar mais  |

---

### reservas
| Coluna         | Tipo          | Restrições         |
|----------------|---------------|--------------------|
| id_reserva     | INT           | PK, AUTO_INCREMENT |
| id_hospede     | INT           | FK → hospedes      |
| id_quarto      | INT           | FK → quartos       |
| data_checkin   | DATE          | NOT NULL           |
| data_checkout  | DATE          | NOT NULL           |
| status         | VARCHAR(20)   |                    |
| -- ?           | --            | -- adicionar mais  |

---

### hospedagens
| Coluna            | Tipo      | Restrições           |
|-------------------|-----------|----------------------|
| id_hospedagem     | INT       | PK, AUTO_INCREMENT   |
| id_reserva        | INT       | FK → reservas        |
| checkin_real      | DATETIME  |                      |
| checkout_real     | DATETIME  |                      |
| -- ?              | --        | -- adicionar mais    |

---

### pagamentos
| Coluna         | Tipo          | Restrições           |
|----------------|---------------|----------------------|
| id_pagamento   | INT           | PK, AUTO_INCREMENT   |
| id_hospedagem  | INT           | FK → hospedagens     |
| valor          | DECIMAL(10,2) | NOT NULL             |
| metodo         | VARCHAR(30)   |                      |
| -- ?           | --            | -- adicionar mais    |

---

### funcionarios
| Coluna          | Tipo         | Restrições         |
|-----------------|--------------|--------------------|
| id_funcionario  | INT          | PK, AUTO_INCREMENT |
| nome            | VARCHAR(100) | NOT NULL           |
| cargo           | VARCHAR(50)  |                    |
| -- ?            | --           | -- adicionar mais  |

---

### servicos *(tabela a ser desenvolvida)*
> Pense: quais colunas são necessárias para descrever um serviço do hotel?

| Coluna    | Tipo | Restrições |
|-----------|------|------------|
| -- ?      | --   | --         |

---

### feedbacks *(tabela a ser desenvolvida)*
> Pense: como relacionar uma avaliação ao hóspede e ao quarto? Quais dados devem ser registrados?

| Coluna | Tipo | Restrições |
|--------|------|------------|
| -- ?   | --   | --         |

---

## Relacionamentos identificados (parcial)

```
hospedes      ||--o{ reservas       : "faz"
quartos       ||--o{ reservas       : "recebe"
reservas      ||--||  hospedagens   : "gera"
hospedagens   ||--o{ pagamentos     : "gera"

-- Quais outros relacionamentos existem?
-- Como os serviços se conectam às hospedagens?
-- Como os funcionários se conectam às hospedagens?
-- Onde ficam os feedbacks?
```

---

## O que ainda precisa ser feito

- [ ] Completar as colunas faltantes nas tabelas existentes
- [ ] Criar a tabela `servicos` com suas colunas e tipos
- [ ] Criar a tabela `feedbacks` com suas colunas e tipos
- [ ] Criar a tabela de associação entre `hospedagens` e `servicos`
- [ ] Definir FK de `funcionarios` nas tabelas corretas
- [ ] Revisar tipos de dados e restrições (`NOT NULL`, `DEFAULT`, `CHECK`, etc.)
- [ ] Garantir que todos os relacionamentos estejam representados

