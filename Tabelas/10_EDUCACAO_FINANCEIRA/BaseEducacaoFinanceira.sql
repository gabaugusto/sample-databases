
-- Criando o banco de dados educacaofinanceira
DROP DATABASE IF EXISTS gestaofinanceirafamiliar;
CREATE DATABASE IF NOT EXISTS gestaofinanceirafamiliar;

-- Selecionando o banco de dados educacaofinanceira
USE gestaofinanceirafamiliar;

-- ///////////////////////////////////////////////////////////////////////////////////
-- Criando a tabela familias
CREATE TABLE IF NOT EXISTS familias(
    id_familia      INT AUTO_INCREMENT PRIMARY KEY
    ,nome_familia   VARCHAR(70) NOT NULL
    ,data_cadastro  DATE NOT NULL
    ,`status`       BIT
) ENGINE=InnoDB;

-- Inserindo dados na tabela familias
INSERT INTO familias(id_familia,nome_familia,data_cadastro,`status`) VALUES (10,'Amari','2022-04-01',1);
INSERT INTO familias(id_familia,nome_familia,data_cadastro,`status`) VALUES (11,'Teixeira','2022-03-12',1);
INSERT INTO familias(id_familia,nome_familia,data_cadastro,`status`) VALUES (20,'Oliveira','2023-05-22',1);
INSERT INTO familias(id_familia,nome_familia,data_cadastro,`status`) VALUES (30,'Silva e Silva','2022-06-01',1);
INSERT INTO familias(id_familia,nome_familia,data_cadastro,`status`) VALUES (40,'Costa','2024-04-01',1);
INSERT INTO familias(id_familia,nome_familia,data_cadastro,`status`) VALUES (50,'Lima','2024-04-01',1);
INSERT INTO familias(id_familia,nome_familia,data_cadastro,`status`) VALUES (60,'Santos','2024-04-01',1);

-- ///////////////////////////////////////////////////////////////////////////////////
-- Criando a tabela usuarios
CREATE TABLE IF NOT EXISTS usuarios(
    id_usuario      INT AUTO_INCREMENT PRIMARY KEY
    ,nome_usuario   VARCHAR(70) NOT NULL
    ,email          VARCHAR(70) NOT NULL
    ,senha          VARCHAR(70) NOT NULL
    ,id_familia     INT DEFAULT 0
    ,data_cadastro  DATE NOT NULL
    ,`status`       BIT
) ENGINE=InnoDB;

-- Inserindo dados na tabela usuarios
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Ada Amari','ada@gmail.com','123456',10,'2022-04-01',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Abeba Amari','abeba@outlook.com','123456',10,'2022-06-09',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Hugo Teixeira', 'hteixeira@gmail.com','123456',11,'2023-12-01',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('João Silva', 'joao_silva@protonmal.com','123456',30,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Maria Pedro Bruno Oliveira', 'mariaoliveira@bol.com.br','123456',20,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Maria Fernanda Silva', 'mafe_silva@protonmail.com','123456',30,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Fernanda Costa', 'fema_costa@mailproton.com','123456',40,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Roberto Macedo Costa', 'fema_costa@mailproton.com','123456',40,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Ana Maya Costa Lima', 'anamaya@gmail.com','123456',50,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Pedro Macedo Teixeira Lima', 'pedrinho_teixeira@gmnail.com','123456',50,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Carlos Pedro Bruno Oliveira', 'cpbo@bol.com.br','123456',20,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Juliana Karina Pedro Bruno Oliveira', 'jk_pedrob_oliveira@bol.com.br','123456',20,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Marina Santos', 'marinasantos@aol.com.br','123456',60,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Mariana Peixoto Santos', 'marianapeixoto@bol.com.br','123456',60,'2023-09-11',1);
INSERT INTO usuarios(nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES ('Esther Lopes Peixoto ', 'marianapeixoto@bol.com.br','123456',60,'2023-09-11',1);

-- Usuario Master
INSERT INTO usuarios(id_usuario,nome_usuario,email,senha,id_familia,data_cadastro,`status`) VALUES (100000,'master','master@master.com','123456',10,'2022-04-01',1);

-- ///////////////////////////////////////////////////////////////////////////////////
-- Criando a tabela usuarios x familias
-- A tabela usuarios_familias é uma tabela de relacionamento entre as tabelas usuarios e familias. 
-- Também é conhecida como tabela de junção ou tabela de associação.
CREATE TABLE IF NOT EXISTS usuarios_familias(
    id_usuario_familia INT AUTO_INCREMENT PRIMARY KEY
    ,id_usuario         INT NOT NULL
    ,id_familia         INT NOT NULL
    ,`status`           BIT
) ENGINE=InnoDB;

-- Inserindo dados na tabela usuarios x familias
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (1,10,1); -- // Ada Amari
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (2,10,1); -- // Abeba Amari
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (3,11,1); -- // Hugo Teixeira
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (4,30,1); -- // João Silva
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (5,20,1); -- // Maria Oliveira
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (6,30,1); -- // Maria Fernanda Silva
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (7,40,1); -- // Fernanda Costa
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (8,40,1); -- // Roberto Macedo Costa
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (9,50,1); -- // Ana Maya Costa Lima
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (10,50,1); -- // Pedro Macedo Teixeira Lima
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (11,20,1); -- // Carlos Pedro Bruno Oliveira
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (12,20,1); -- // Juliana Karina Pedro Bruno Oliveira
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (13,60,1); -- // Marina Santos
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (14,60,1); -- // Mariana Peixoto Santos
INSERT INTO usuarios_familias(id_usuario,id_familia,`status`) VALUES (15,60,1); -- // Esther Lopes Peixoto

-- ///////////////////////////////////////////////////////////////////////////////////
-- Criando a tabela tipos
CREATE TABLE IF NOT EXISTS  `tipos` (
  `id_tipo`   INT NOT NULL AUTO_INCREMENT,
  `tipo_nome` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_tipo`)
);

-- Inserindo dados na tabela tipos
INSERT INTO `tipos` VALUES (1,'Receita'),(2,'Conta');

-- ///////////////////////////////////////////////////////////////////////////////////
-- Criando a tabela categorias
CREATE TABLE IF NOT EXISTS categorias(
    id_categoria    INT AUTO_INCREMENT PRIMARY KEY
    ,nome_categoria VARCHAR(20) NOT NULL
);

INSERT INTO categorias(nome_categoria) VALUES ('Essencial');
INSERT INTO categorias(nome_categoria) VALUES ('Mercado');
INSERT INTO categorias(nome_categoria) VALUES ('Carro');
INSERT INTO categorias(nome_categoria) VALUES ('Lazer');
INSERT INTO categorias(nome_categoria) VALUES ('Emergencial');
INSERT INTO categorias(nome_categoria) VALUES ('Outros');
INSERT INTO categorias(nome_categoria) VALUES ('Renda');

-- ///////////////////////////////////////////////////////////////////////////////////
-- Criando a tabela fontes
CREATE TABLE IF NOT EXISTS fontes(
    id_fonte        INT AUTO_INCREMENT PRIMARY KEY
    ,fonte_nome     VARCHAR(55) NOT NULL
);

-- Inserindo dados na tabela fontes
INSERT INTO `fontes` VALUES (1,'Cartão de Crédito Alpha'),(2,'Cartão de Crédito Beta'),(3,'Dinheiro');

-- ///////////////////////////////////////////////////////////////////////////////////
-- Criando a tabela transacoes
CREATE TABLE IF NOT EXISTS transacoes(
    id_registro       INT AUTO_INCREMENT PRIMARY KEY
    ,data_transacoes    DATE NOT NULL
    ,descricao        VARCHAR(255) NOT NULL
    ,id_categoria     VARCHAR(70) default 'Outros'
    ,valor            FLOAT NOT NULL
    ,id_usuario       INT NOT NULL
    ,id_tipo          INT NOT NULL
    ,id_fonte         VARCHAR(70)
    ,`status`         BIT
) ENGINE=InnoDB; -- Engine InnoDB é a engine padrão do MySQL a partir da versão 5.5. O que ele faz? Ele garante a integridade dos dados, ou seja, se você tentar inserir um registro que não existe na tabela pai, ele não vai deixar.

-- Inserindo dados na tabela transacoes por último, pois ela depende das outras tabelas
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-01','Salario Ada',7,3000,1,NULL,1, 1);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-05','Salário Abeba ',7,2500,1,NULL,0, 2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-10','Pensão de Abeba ',7,202.10,1,1,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-02','Aluguel',1,1200,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-05','Conta de Água',1,1238,0,1,1,1);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-07','Conta de Internet',1,80,0,3,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-20','Supermercado',2,600,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-25','Combustível',3,2000,0,3,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-28','Cinema com a família',0,119.85,0,1,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-03','Reparo do carro',5,350.0,0,1,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-08','Pagamento de Empréstimo',NULL,411.98,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-10','Jantar fora',NULL,158,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-12','Material escolar dos filhos',NULL,250.00,1,1,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-15','Streaming (Netflix + Max)',NULL,100,0,3,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-03','Gasolina',NULL,4399,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-01','Salario Ada',7,3000.00,1,NULL,0,1);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-05','Salário Abeba ',7,2200,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-10','Pensão de Abeba ',7,200,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-02','Aluguel',1,1200.00,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-05','Conta de Água',1,100,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-15','Streaming (Netflix + Max)',NULL,100,0,3,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-07','Conta de Internet',1,80,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-18','Supermercado',2,500,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-10','Combustível',NULL,150.00,0,2,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-12','Cinema com a família',NULL,80.00,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-15','Reparo do carro',NULL,300.00,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-20','Pagamento de Empréstimo',5,350,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-25','Jantar fora',4,120,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-28','Material escolar dos filhos',1,200,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-01','Salario Ada',7,3100.00,1,NULL,0,1);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-05','Salário Abeba ',7,2400.05,1,1,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-10','Pensão de Abeba ',NULL,200,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-02','Aluguel',NULL,1000,0,1,1,1);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-05','Conta de Água',NULL,87,0,2,1,1);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-07','Conta de Internet',NULL,193,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-08','Supermercado',NULL,890,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-10','Combustível',3,180,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-12','Cinema com a família',4,100,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-15','Reparo do carro',5,200,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-20','Pagamento de Empréstimo',5,400,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-25','Jantar fora',4,150,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-02-28','Remédio',1,250,0,2,1,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-01-22','Saque-Aniversário',NULL,1000,1,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-01','Salario Ada',7,3200.00,1,NULL,0,1);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-05','Salário Abeba ',7,2600.00,1,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-05','Pensão de Abeba ',7,200,1,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-02','Aluguel',NULL,2000,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-05','Conta de Água',NULL,119,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-15','Streaming (Netflix + Max)',NULL,100,0,3,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-07','Conta de Internet',NULL,80,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-08','Supermercado',NULL,550,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-10','Combustível',NULL,160,0,1,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-12','Cinema com a família',4,108,0,1,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-15','Viagem para a Praia',5,344,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-20','Pagamento de Empréstimo',5,380,0,1,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-25','Jantar fora',4,130,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-28','Material escolar dos filhos',1,270,0,NULL,0,2);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-03-10','Restituição IR',NULL,1380.10,0,NULL,0,2);

-- Hugo Teixeira
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-01','Salario',7,3000,1,NULL,1,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-05','Freelance 1',7,398,1,NULL,0,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-10','Freelance 2',7,202.10,1,1,1,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-02','Aluguel',1,1200,0,2,1,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-05','Conta de Água',1,1238,0,1,1,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-07','Conta de Internet',1,80,0,3,1,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-20','Supermercado',2,312,0,2,1,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-25','Uber',3,398,0,3,1,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-28','Festa do Hugo',0,119.85,0,1,0,3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-03','Diarista',5,350.0,0,1,0, 3);
INSERT INTO transacoes(data_transacoes,descricao,id_categoria,valor,id_tipo,id_fonte,`status`,id_usuario) VALUES ('2024-04-08','Reserva de Emergência',NULL,280.98,0,2,1,3);

-- Receitas da família Silva e Silva
INSERT INTO transacoes(data_transacoes, descricao, id_categoria, valor, id_tipo, id_fonte, `status`, id_usuario) VALUES 
('2024-04-01', 'Salário João', 1, 5000, 1, NULL, 1, 4),
('2024-04-01', 'Salário Maria', 1, 4000, 1, NULL, 1, 6),
('2024-04-02', 'Aluguel', 2, 1500, 2, NULL, 1, 6),
('2024-04-03', 'Conta de luz', 2, 200, 2, NULL, 1, 6),
('2024-04-04', 'Conta de água', 2, 100, 2, NULL, 1, 6),
('2024-04-05', 'Empréstimo bancário', 3, 300, 2, NULL, 1, 4),
('2024-04-10', 'Atividades extracurriculares dos filhos', 4, 500, 2, NULL, 1, 6),
('2024-04-15', 'Cinema em família', 5, 150, 2, NULL, 1, 6),
('2024-04-20', 'Despesas com o carro', 6, 250, 2, NULL, 1, 4);

-- Receitas da Familia Costa
INSERT INTO transacoes(data_transacoes, descricao, id_categoria, valor, id_tipo, id_fonte, `status`, id_usuario) VALUES 
('2024-04-01', 'Renda Roberto', 7, 3000, 1, NULL, 1, 8),
('2024-04-01', 'Vendas Fernanda', 7, 2500, 1, NULL, 1, 7),
('2024-04-02', 'Aluguel', 2, 1200, 2, NULL, 1, 8),
('2024-04-03', 'Compra de materiais para confeitaria', 7, 300, 2, NULL, 1, 8),
('2024-04-04', 'Despesas escolares dos filhos', 2, 600, 2, NULL, 1, 8),
('2024-04-05', 'Despesas médicas', 8, 400, 2, NULL, 1, 8),
('2024-04-10', 'Viagem de fim de semana', 5, 350, 2, NULL, 1, 8),
('2024-04-15', 'Despesas com o carro', 6, 200, 2, NULL, 1, 8),
('2024-04-20', 'Despesas com a casa de praia', 7, 300, 2, NULL, 1, 8),
('2024-04-25', 'Despesas com o carro', 6, 200, 2, NULL, 1, 8),
('2024-03-05', 'Conta de Água',NULL,119,0,NULL,0,8),
('2024-03-15', 'Presente do Ulisses',NULL,89.90,0,3,0,8),
('2024-03-07', 'Conta de Internet',NULL,80,0,NULL,0,8),
('2024-03-08', 'Supermercado',NULL,260,0,NULL,0,8),
('2024-03-05', 'Conta de Água',NULL,119,0,NULL,0,8),
('2024-03-15', 'Netflix',NULL,89.90,0,3,0,8),
('2024-03-07', 'Conta de Internet',NULL,80,0,NULL,0,8),
('2024-03-08', 'Supermercado',NULL,550,0,NULL,0,8);

-- Receitas da Familia Lima
INSERT INTO transacoes(data_transacoes, descricao, id_categoria, valor, id_tipo, id_fonte, `status`, id_usuario) VALUES 
('2024-04-01', 'Salário Ana',7, 3500, 1, NULL, 1, 9),
('2024-04-01', 'Salário Pedro', 7, 3000, 1, NULL, 1, 10),
('2024-04-02', 'Aluguel', 2, 1400, 2, NULL, 1, 10),
('2024-04-03', 'Conta de luz', 2, 180, 2, NULL, 1, 9),
('2024-04-04', 'Conta de água', 2, 90, 2, NULL, 1, 10),
('2024-04-05', 'Despesas com o bebê', 4, 500, 2, NULL, 1, 9),
('2024-04-10', 'Consultas médicas', 8, 250, 2, NULL, 1, 10),
('2024-04-15', 'Compras para o lar', 7, 600, 2, NULL, 1, 9),
('2024-03-05', 'Conta de Água',NULL,119,0,NULL,0,9),
('2024-03-15', 'Netflix',NULL,89.90,0,3,0,9),
('2024-03-07', 'Conta de Internet',NULL,80,0,NULL,0,9),
('2024-03-08', 'Supermercado',NULL,550,0,NULL,0,9);

-- Receitas da Familia Oliveira
INSERT INTO transacoes(data_transacoes, descricao, id_categoria, valor, id_tipo, id_fonte, `status`, id_usuario) VALUES 
('2024-04-01', 'Renda Variavel Carlos', 7, 300, 1, NULL, 1, 5),
('2024-04-01', 'Renda Variavel Juliana', 7, 500, 1, NULL, 1, 11),
('2024-04-01', 'Renda Variavel da Mariana', 7, 500, 1, NULL, 1, 12),
('2024-04-02', 'Aluguel', 2, 1800, 2, NULL, 1, 5),
('2024-04-03', 'Mensalidade universitária', 2, 800, 2, NULL, 1, 11),
('2024-04-04', 'Despesas com alimentação', 7, 700, 2, NULL, 1, 12),
('2024-04-05', 'Atividades dos pets', 4, 400, 2, NULL, 1, 5),
('2024-04-10', 'Manutenção de propriedades', 6, 250, 2, NULL, 1, 12),
('2024-04-15', 'Despesas com o carro', 6, 600, 2, NULL, 1, 5),
('2024-04-20', 'Despesas com a casa de praia', 7, 300, 2, NULL, 1, 11),
('2024-04-25', 'Despesas com o carro', 6, 200, 2, NULL, 1, 12),
('2024-03-05', 'Conta de Água',NULL,119,0,NULL,0,5),
('2024-03-15', 'Netflix',NULL,89.90,0,3,0,11),
('2024-03-07', 'Conta de Internet',NULL,80,0,NULL,0,11),
('2024-03-08', 'Supermercado',NULL,550,0,NULL,0,11),
('2024-04-10', 'Renda Variavel Juliana', 7, 250, 2, NULL, 1, 11);

-- Receitas da Familia Almeida
INSERT INTO transacoes(data_transacoes, descricao, id_categoria, valor, id_tipo, id_fonte, `status`, id_usuario) VALUES 
('2024-04-01', 'Salário Marina', 1, 1200, 1, NULL, 1, 13),
('2024-04-01', 'Renda Mariana', 1, 120, 1, NULL, 1, 14),
('2024-03-30', 'Aposentadoria Esther', 1, 2800, 1, NULL, 1, 15),
('2024-04-02', 'Aluguel', 2, 1300, 2, NULL, 1, 14),
('2024-04-03', 'Despesas com a faculdade', 4, 1400, 2, NULL, 1, 14),
('2024-04-04', 'Compra de materiais para trabalho de Mariana', 7, 200, 2, NULL, 1, 14),
('2024-04-05', 'Consultas médicas', 8, 450, 2, NULL, 1, 14),
('2024-03-05', 'Conta de Água', NULL, 119, 0, NULL, 0, 14),
('2024-03-15', 'Netflix', NULL, 89.90, 0, 3, 0, 14),
('2024-03-07', 'Conta de Internet', NULL, 80, 0, NULL, 0, 14),
('2024-03-08', 'Supermercado', NULL, 550, 0, NULL, 0, 14);

-- ///////////////////////////////////////////////////////////////////////////////////
-- VIEWS são consultas salvas no banco de dados.
-- Elas são úteis para simplificar consultas complexas, facilitar a manutenção e garantir a segurança dos dados.

-- Criando a view que traz as receitas de cada família
CREATE OR REPLACE VIEW receitas_familias AS
SELECT 
    SUM(valor) AS total_receitas,
    familias.nome_familia
    FROM transacoes
    INNER JOIN usuarios ON transacoes.id_usuario = usuarios.id_usuario
    INNER JOIN familias ON usuarios.id_familia = familias.id_familia
    WHERE transacoes.id_tipo = 1
	GROUP BY familias.nome_familia;

-- Criando a view que traz as receitas de cada família agrupando por categoria
CREATE OR REPLACE VIEW receitas_familias_categoria AS
SELECT 
    SUM(valor) AS total_receitas,
    familias.nome_familia,
    categorias.nome_categoria
    FROM transacoes
    INNER JOIN usuarios ON transacoes.id_usuario = usuarios.id_usuario
    INNER JOIN familias ON usuarios.id_familia = familias.id_familia
    INNER JOIN categorias ON transacoes.id_categoria = categorias.id_categoria
    WHERE NOT transacoes.id_tipo = 1
    GROUP BY familias.nome_familia, categorias.nome_categoria;

-- Criando a view que traz os gastos de cada família
CREATE OR REPLACE VIEW gastos_familias AS
SELECT 
    SUM(valor) AS total_gastos,
    familias.nome_familia
    FROM transacoes
    INNER JOIN usuarios ON transacoes.id_usuario = usuarios.id_usuario
    INNER JOIN familias ON usuarios.id_familia = familias.id_familia
    WHERE transacoes.id_tipo = 0
	GROUP BY familias.nome_familia;

-- Criando a view que registras os gastos e as receitas de cada usuario
CREATE OR REPLACE VIEW gastos_usuarios AS
SELECT 
    SUM(valor) AS total_gastos,
    usuarios.nome_usuario
    FROM transacoes
    INNER JOIN usuarios ON transacoes.id_usuario = usuarios.id_usuario
    WHERE transacoes.id_tipo = 0
    GROUP BY usuarios.nome_usuario;

CREATE OR REPLACE VIEW receitas_usuarios AS
SELECT 
    SUM(valor) AS total_receitas,
    usuarios.nome_usuario
    FROM transacoes
    INNER JOIN usuarios ON transacoes.id_usuario = usuarios.id_usuario
    WHERE transacoes.id_tipo = 1
    GROUP BY usuarios.nome_usuario;    


-- ///////////////////////////////////////////////////////////////////////////////////
-- Extra: Criando a view que traz todas as informações de famílias, usuários e transações
CREATE OR REPLACE VIEW dados_consolidados AS
SELECT 
    f.id_familia AS family_id,
    f.nome_familia AS family_name,
    f.data_cadastro AS family_created_at,
    f.status AS family_status,
    u.id_usuario AS user_id,
    u.nome_usuario AS user_name,
    u.email AS user_email,
    u.senha AS user_password,
    u.data_cadastro AS user_created_at,
    u.status AS user_status,
    t.id_registro AS transaction_id,
    t.data_transacoes AS transaction_date,
    t.descricao AS transaction_description,
    c.nome_categoria AS transaction_category,
    t.valor AS transaction_amount,
    CASE WHEN t.id_tipo = 1 THEN 'Income' ELSE 'Expense' END AS transaction_type,
    fo.fonte_nome AS transaction_source,
    t.status AS transaction_status
FROM 
    familias f
LEFT JOIN 
    usuarios u ON f.id_familia = u.id_familia
LEFT JOIN 
    transacoes t ON u.id_usuario = t.id_usuario
LEFT JOIN 
    categorias c ON t.id_categoria = c.id_categoria
LEFT JOIN 
    fontes fo ON t.id_fonte = fo.id_fonte
ORDER BY 
    f.id_familia, u.id_usuario, t.id_registro;
    
SELECT * from dados_consolidados;