# Hotel Nebula — Esquema das Coleções

---

## 1. `hospedes`

Armazena os dados cadastrais dos hóspedes. Documentos embutidos são usados para endereço e preferências, pois são dados fortemente vinculados ao hóspede.

```json
{
  "_id": "ObjectId('hsp001')",
  "nome": "Carlos Andrade",
  "cpf": "123.456.789-00",
  "email": "carlos.andrade@email.com",
  "telefone": "+55 11 98765-4321",
  "data_nascimento": "1985-03-22",
  "nacionalidade": "Brasileiro",
  "endereco": {
    "logradouro": "Rua das Palmeiras, 142",
    "cidade": "São Paulo",
    "estado": "SP",
    "cep": "01310-100",
    "pais": "Brasil"
  },
  "preferencias": {
    "tipo_quarto": "suite",
    "andar_alto": true,
    "fumante": false,
    "cama": "king"
  },
  "data_cadastro": "2024-01-15T10:30:00Z",
  "ativo": true
}
```

---

## 2. `quartos`

Representa os quartos disponíveis no hotel. Comodidades são armazenadas como array de strings para permitir buscas flexíveis.

```json
{
  "_id": "ObjectId('qrt101')",
  "numero": "101",
  "andar": 1,
  "tipo": "standard",
  "categoria": "economico",
  "capacidade_max": 2,
  "preco_diaria": 250.00,
  "descricao": "Quarto padrão com vista para o jardim interno.",
  "comodidades": [
    "ar-condicionado",
    "tv 42\"",
    "frigobar",
    "wifi",
    "cofre"
  ],
  "caracteristicas": {
    "vista": "jardim",
    "banheira": false,
    "varanda": false,
    "area_m2": 28
  },
  "status": "disponivel",
  "fotos": [
    "https://storage.hotelnebula.com/quartos/101/foto1.jpg",
    "https://storage.hotelnebula.com/quartos/101/foto2.jpg"
  ],
  "ultima_limpeza": "2025-03-31T08:00:00Z"
}
```

---

## 3. `reservas`

Registra reservas feitas pelos hóspedes. O hóspede é referenciado por ID, mas um snapshot dos dados essenciais é embutido para preservar histórico mesmo que o cadastro mude.

```json
{
  "_id": "ObjectId('rsv2024001')",
  "hospede_id": "ObjectId('hsp001')",
  "hospede_snapshot": {
    "nome": "Carlos Andrade",
    "email": "carlos.andrade@email.com",
    "telefone": "+55 11 98765-4321"
  },
  "quarto_id": "ObjectId('qrt101')",
  "quarto_snapshot": {
    "numero": "101",
    "tipo": "standard",
    "preco_diaria": 250.00
  },
  "data_checkin": "2025-04-10",
  "data_checkout": "2025-04-14",
  "num_noites": 4,
  "num_hospedes": 2,
  "valor_total": 1000.00,
  "status": "confirmada",
  "canal": "site_proprio",
  "codigo_reserva": "HN-2025-00142",
  "observacoes": "Solicita berço para bebê.",
  "data_criacao": "2025-03-28T14:22:00Z",
  "data_atualizacao": "2025-03-28T14:22:00Z"
}
```

---

## 4. `hospedagens`

Representa o período em que o hóspede está efetivamente hospedado (check-in realizado). Serviços consumidos ficam embutidos como array, pois compõem a conta do hóspede e pertencem ao contexto da estadia.

```json
{
  "_id": "ObjectId('hpd2025001')",
  "reserva_id": "ObjectId('rsv2024001')",
  "hospede_id": "ObjectId('hsp001')",
  "quarto_id": "ObjectId('qrt101')",
  "checkin_real": "2025-04-10T14:35:00Z",
  "checkout_real": "2025-04-14T11:10:00Z",
  "status": "encerrada",
  "funcionario_checkin_id": "ObjectId('fnc005')",
  "funcionario_checkout_id": "ObjectId('fnc008')",
  "servicos_consumidos": [
    {
      "servico_id": "ObjectId('svc003')",
      "nome": "Café da manhã",
      "quantidade": 2,
      "preco_unitario": 45.00,
      "total": 90.00,
      "data": "2025-04-11T08:15:00Z"
    },
    {
      "servico_id": "ObjectId('svc011')",
      "nome": "Lavanderia",
      "quantidade": 1,
      "preco_unitario": 80.00,
      "total": 80.00,
      "data": "2025-04-12T10:00:00Z"
    },
    {
      "servico_id": "ObjectId('svc019')",
      "nome": "Minibar",
      "quantidade": 3,
      "preco_unitario": 25.00,
      "total": 75.00,
      "data": "2025-04-13T22:30:00Z"
    }
  ],
  "total_servicos": 245.00,
  "total_diarias": 1000.00,
  "total_geral": 1245.00,
  "observacoes": "Hóspede solicitou late checkout, atendido."
}
```

---

## 5. `pagamentos`

Registra os pagamentos vinculados a uma hospedagem. Um array de parcelas permite representar pagamentos parcelados ou múltiplos métodos.

```json
{
  "_id": "ObjectId('pgt2025001')",
  "hospedagem_id": "ObjectId('hpd2025001')",
  "reserva_id": "ObjectId('rsv2024001')",
  "hospede_id": "ObjectId('hsp001')",
  "valor_total": 1245.00,
  "status": "pago",
  "data_pagamento": "2025-04-14T11:05:00Z",
  "parcelas": [
    {
      "metodo": "cartao_credito",
      "bandeira": "Visa",
      "valor": 1000.00,
      "num_parcelas": 1,
      "status": "aprovado",
      "transacao_id": "TXN-VISA-00392"
    },
    {
      "metodo": "pix",
      "valor": 245.00,
      "status": "aprovado",
      "transacao_id": "TXN-PIX-00841"
    }
  ],
  "nota_fiscal": "NF-e 000421",
  "data_criacao": "2025-04-14T11:05:00Z"
}
```

---

## 6. `funcionarios`

Gerencia os profissionais do hotel. Documentos de turno e permissões são embutidos por serem de uso frequente junto ao cadastro.

```json
{
  "_id": "ObjectId('fnc005')",
  "nome": "Juliana Martins",
  "cpf": "987.654.321-11",
  "email": "juliana.martins@hotelnebula.com",
  "telefone": "+55 21 99123-4567",
  "cargo": "recepcionista",
  "departamento": "recepção",
  "turno": {
    "tipo": "manha",
    "entrada": "07:00",
    "saida": "15:00"
  },
  "permissoes": [
    "checkin",
    "checkout",
    "reservas_visualizar",
    "reservas_editar"
  ],
  "data_admissao": "2022-08-01",
  "salario": 3200.00,
  "ativo": true
}
```

---

## 7. `servicos`

Catálogo de serviços disponíveis no hotel. Separado das hospedagens para facilitar atualizações de preços e adição de novos serviços.

```json
{
  "_id": "ObjectId('svc003')",
  "nome": "Café da manhã",
  "categoria": "alimentacao",
  "descricao": "Café da manhã completo no restaurante do hotel.",
  "preco": 45.00,
  "unidade": "pessoa",
  "disponivel": true,
  "horario_disponivel": {
    "inicio": "06:30",
    "fim": "10:30"
  },
  "tags": ["incluso_suite", "buffet", "opcao_vegana"]
}
```

---

## 8. `feedbacks`

Avaliações dos hóspedes ficam em coleção própria (não embutidas no quarto), permitindo consultas, filtros e cálculo de médias sem precisar carregar o documento inteiro do quarto.

```json
{
  "_id": "ObjectId('fdb2025001')",
  "hospede_id": "ObjectId('hsp001')",
  "hospedagem_id": "ObjectId('hpd2025001')",
  "quarto_id": "ObjectId('qrt101')",
  "data_avaliacao": "2025-04-15T09:00:00Z",
  "nota_geral": 4.5,
  "notas_detalhadas": {
    "limpeza": 5,
    "atendimento": 5,
    "conforto": 4,
    "custo_beneficio": 4,
    "localizacao": 5
  },
  "comentario": "Ótima estadia! A equipe foi muito atenciosa e o quarto estava impecável. O café da manhã é excelente. Voltarei com certeza.",
  "resposta_hotel": {
    "texto": "Obrigado pelo feedback, Carlos! Ficamos felizes com sua visita e esperamos recebê-lo novamente em breve.",
    "data": "2025-04-16T10:30:00Z",
    "funcionario_id": "ObjectId('fnc005')"
  },
  "visivel": true
}
```

---

## Resumo das Relações

| Coleção        | Referencia                          | Embute                                      |
|----------------|-------------------------------------|---------------------------------------------|
| `reservas`     | `hospedes`, `quartos`               | snapshot do hóspede e do quarto             |
| `hospedagens`  | `reservas`, `hospedes`, `quartos`, `funcionarios` | array de serviços consumidos   |
| `pagamentos`   | `hospedagens`, `reservas`, `hospedes` | array de parcelas/métodos de pagamento    |
| `feedbacks`    | `hospedes`, `hospedagens`, `quartos` | notas detalhadas, resposta do hotel        |
| `funcionarios` | —                                   | turno, permissões                           |
| `quartos`      | —                                   | comodidades, características                |
| `hospedes`     | —                                   | endereço, preferências                      |
| `servicos`     | —                                   | horário disponível, tags                    |
