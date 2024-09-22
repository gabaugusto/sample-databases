/*
10	Uniforme do Superman	1	300.13	2023-06-19
167	Uniforme do Superman	1	300.13	2023-07-10
14	Fake Batarang	2	239.29	2023-07-29
10	Lança-Teias	3	237.19	2023-07-13
19	Lança-Teias	3	237.19	2023-06-05
29	Capacete do Homem-Formiga	4	289.29	2023-07-19
55	Capacete do Homem-Formiga	4	289.29	2023-06-21
17	Nulificador Total	5	750.19	2023-06-13
19	Nulificador Total	5	750.19	2023-07-18
13	Laço da Verdade	6	325.13	2023-06-14
15	Laço da Verdade	6	325.13	2023-06-10
22	Sabre de Luz (Mace Windu)	8	990.29	2023-06-15
14	Sentinelas do Bolivar Trask	9	150.13	2023-06-20
13	Uniforme de Moléculas Instáveis	10	158.29	2023-06-29
10	Uniforme de Moléculas Instáveis	10	158.29	2023-07-20
8	Laço da Honestidade	11	649.29	2023-07-21
3	Batarangs Oficiais	12	900.29	2023-07-05
*/

db.vendas.insertMany([{
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e46"),
    "produto": "Uniforme do Superman",
    "quantidade": 1,
    "precoUnitario": 300.13,
    "dataVenda": "2023-06-19",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e55")
},
{
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e47"),
    "produto": "Uniforme do Superman",
    "quantidade": 1,
    "precoUnitario": 300.13,
    "dataVenda": "2023-07-10",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e54")
},
{
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e48"),
    "produto": "Fake Batarang",
    "quantidade": 2,
    "precoUnitario": 239.29,
    "dataVenda": "2023-07-29",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e53")
},
{
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e49"),
    "produto": "Lança-Teias",
    "quantidade": 3,
    "precoUnitario": 237.19,
    "dataVenda": "2023-07-13"
},
{
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4a"),
    "produto": "Lança-Teias",
    "quantidade": 3,
    "precoUnitario": 237.19,
    "dataVenda": "2023-06-05",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e52")
},
{
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4b"),
    "produto": "Capacete do Homem-Formiga",
    "quantidade": 4,
    "precoUnitario": 289.29,
    "dataVenda": "2023-07-19",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e58")
},
{
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4c"),
    "produto": "Capacete do Homem-Formiga",
    "quantidade": 4,
    "precoUnitario": 289.29,
    "dataVenda": "2023-06-21",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e57")
}, {
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4d"),
    "produto": "Nulificador Total",
    "quantidade": 5,
    "precoUnitario": 750.19,
    "dataVenda": "2023-06-13",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e56")
}, {
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4e"),
    "produto": "Nulificador Total",
    "quantidade": 5,
    "precoUnitario": 750.19,
    "dataVenda": "2023-07-18",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e55")
}, {
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e4f"),
    "produto": "Laço da Verdade",
    "quantidade": 6,
    "precoUnitario": 325.13,
    "dataVenda": "2023-06-14",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e58")
}, {
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e50"),
    "produto": "Laço da Verdade",
    "quantidade": 6,
    "precoUnitario": 325.13,
    "dataVenda": "2023-06-10",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e57")
}, {
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e51"),
    "produto": "Sabre de Luz (Mace Windu)",
    "quantidade": 8,
    "precoUnitario": 990.29,
    "dataVenda": "2023-06-15",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e56")
}, {
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e52"),
    "produto": "Sentinelas do Bolivar Trask",
    "quantidade": 9,
    "precoUnitario": 150.13,
    "dataVenda": "2023-06-20",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e57")
}, {
    "_id": ObjectId("5f8b3f3f9b3e0b3b3c1e3e53"),
    "produto": "Uniforme de Moléculas Instáveis",
    "quantidade": 10,
    "precoUnitario": 158.29,
    "dataVenda": "2023-06-29",
    "vendedor": ObjectId("5f8b3f3f9b3e0b3b3c1e3e56")
}])