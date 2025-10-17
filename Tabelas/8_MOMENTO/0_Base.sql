DROP DATABASE IF EXISTS momento;
CREATE DATABASE IF NOT EXISTS momento;
USE momento;

DROP TABLE IF EXISTS regioes;
CREATE TABLE regioes (
  regiao_id INT AUTO_INCREMENT PRIMARY KEY,
  regiao_nome VARCHAR(25) NOT NULL
);

DROP TABLE IF EXISTS paises;
CREATE TABLE paises (
  pais_id CHAR(2) PRIMARY KEY,
  pais_nome VARCHAR(48) NOT NULL,
  regiao_id INT NOT NULL, 
  FOREIGN KEY (regiao_id) REFERENCES regioes (regiao_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS escritorios;
CREATE TABLE escritorios (
  escritorio_id INT AUTO_INCREMENT PRIMARY KEY,
  escritorio_nome VARCHAR(48) DEFAULT NULL,
  endereco VARCHAR(48) NOT NULL,
  cep VARCHAR(12) DEFAULT NULL,
  cidade VARCHAR(48) NOT NULL,
  estado_provincia VARCHAR(24) NOT NULL,
  pais_id CHAR(2) NOT NULL,
  FOREIGN KEY (pais_id) REFERENCES paises (pais_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE suprimentos (
    suprimento_id INT PRIMARY KEY AUTO_INCREMENT,
    suprimento_nome VARCHAR(100),
    quantidade_comprada INT,
    custo DECIMAL(10, 2),
    escritorio_id INT DEFAULT NULL,
	FOREIGN KEY (escritorio_id) REFERENCES escritorios (escritorio_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS departamentos;
CREATE TABLE departamentos (
  departamento_id INT AUTO_INCREMENT PRIMARY KEY,
  departamento_nome VARCHAR(30) NOT NULL,
  escritorio_id INT DEFAULT NULL,
  FOREIGN KEY (escritorio_id) REFERENCES escritorios (escritorio_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS cargos;
CREATE TABLE cargos (
  cargo_id INT AUTO_INCREMENT PRIMARY KEY,
  cargo_nome VARCHAR(64) NOT NULL,
  min_salario DECIMAL(8, 2) DEFAULT NULL,
  max_salario DECIMAL(8, 2) DEFAULT NULL
);

DROP TABLE IF EXISTS funcionarios; 
CREATE TABLE funcionarios (
  funcionario_id INT AUTO_INCREMENT PRIMARY KEY,
  primeiro_nome VARCHAR(24) DEFAULT NULL,
  sobrenome VARCHAR(24) NOT NULL,
  email VARCHAR(128) NOT NULL,
  senha VARCHAR(128) NOT NULL,
  telefone VARCHAR(24) DEFAULT NULL,
  data_contratacao DATE NOT NULL,
  cargo_id INT NOT NULL,
  salario DECIMAL(8, 2) NOT NULL,
  gerente_id INT DEFAULT NULL,
  departamento_id INT NOT NULL,
  FOREIGN KEY (cargo_id) REFERENCES cargos (cargo_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (departamento_id) REFERENCES departamentos (departamento_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (gerente_id) REFERENCES funcionarios (funcionario_id)
);

DROP TABLE IF EXISTS dependentes; 
CREATE TABLE dependentes (
  dependente_id INT AUTO_INCREMENT PRIMARY KEY,
  primeiro_nome VARCHAR(24) NOT NULL,
  sobrenome VARCHAR(24) NOT NULL,
  relacionamento VARCHAR(24) NOT NULL,
  funcionario_id INT NOT NULL,
  FOREIGN KEY (funcionario_id) REFERENCES funcionarios (funcionario_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE produtos (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    produto_nome VARCHAR(125),
    produto_price VARCHAR(125)
);

CREATE TABLE vendas (
    venda_id INT PRIMARY KEY,
    produto_id INT,
    quantidade_vendida INT,
    venda_data DATE,
    funcionario_id INT,
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id),
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id)
);

CREATE TABLE audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    log_acao VARCHAR(100),
    log_ts DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    funcionario_id INT NOT NULL,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Inserting Data
INSERT INTO regioes(regiao_id,regiao_nome) VALUES (1,'Europa');
INSERT INTO regioes(regiao_id,regiao_nome) VALUES (2,'Americas');
INSERT INTO regioes(regiao_id,regiao_nome) VALUES (3,'Asia');
INSERT INTO regioes(regiao_id,regiao_nome) VALUES (4,'Sul da Asia ou Africa');

INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('AR','Argentina', 2);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('AU','Australia', 3);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('BE','Belgium', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('BR','Brazil', 2);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('CA','Canada', 2);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('CH','Switzerland', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('CN','China', 3);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('DE','Germany', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('DK','Denmark', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('EG','Egypt', 4);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('FR','France', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('HK','HongKong', 3);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('IL','Israel', 4);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('IN','India', 3);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('IT','Italy', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('KK','Krakoa', 2);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('JP','Japan', 3);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('KW','Kuwait', 4);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('LE','Latveria', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('MI','Markovia', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('MX','Mexico', 2);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('NG','Nigeria', 4);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('NL','Netherlands', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('QU','Qurac', 4);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('TY','Themyscira', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('SG','Singapore', 3);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('UK','United Kingdom', 1);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('US','United States of America', 2);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('WA','Wakanda', 4);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('ZM','Zambia', 4);
INSERT INTO paises(pais_id,pais_nome,regiao_id) VALUES ('ZW','Zimbabwe', 4);

INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (1400,'Wayne escritorios', '2014 Jabberwocky Rd','26192','Gotham','New York','US');
INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (1500,'Stark Tower','2011 Interiors Blvd','99236','South San Francisco','California','US');
INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (1700,'Sala Winter','2004 Charade Rd','98199','Seattle','Washington','US');
INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (1800,'Arkham Base','147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (2400,"Shuri's Palace",'8204 Arthur St',NULL,'Jabari Village','Birnin Zana','WA');
INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (2500,'Umbrella Corp','Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');
INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (2700,'Archies Mad House','2801 W. Airport Freeway','00616','Green Dale','Bavaria','DE');
INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (3900,'Baxter Building','Excelsior Rd. 7031','00616','London Below','London Above','UK');
INSERT INTO escritorios(escritorio_id,escritorio_nome,endereco,cep,cidade,estado_provincia,pais_id) VALUES (1900,"House of Mystery escritorios",'The Trickster Rd. 42','80925','Newcastle','North East England','UK');

INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Computers', 20, 100000.00, 1400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Impressoras', 3, 500.00, 1400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Papel', 50, 21000.00, 1400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Planners', 20, 1500.00, 1400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Post-its', 5000, 852.65, 1700);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Highlighter', 20, 500.00, 1700);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Notebook', 50, 1000.00, 1700);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Grampeadores', 20, 500.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Computers', 15, 200000.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Impressoras', 20, 500.00, 3900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Papel', 50, 1000.00, 3900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Planners', 20, 500.00, 3900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Post-its', 50, 1000.00, 1900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Highlighter', 20, 500.00, 1900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Notebook', 50, 1000.00, 1800);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Grampeadores', 20, 500.00, 1900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Computers', 40, 200000.00, 3900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Impressoras', 3, 500.00, 2400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Papel', 50, 752.85, 2400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Planners', 20, 500.00, 2400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Post-its', 50, 1000.00, 2400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Highlighter', 20, 500.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Notebook', 50, 1000.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Grampeadores', 20, 500.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Computers', 1, 2000.00, 1400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Impressoras', 2, 500.00, 1400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Papel', 50, 21000.00, 1400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Planners', 20, 1500.00, 1400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Post-its', 50, 1197.42, 1700);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Highlighter', 20, 500.00, 1700);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Notebook', 50, 1000.00, 1700);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Grampeadores', 20, 500.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Computers', 15, 200000.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Impressoras', 1, 500.00, 3900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Papel', 5000, 752.85, 3900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Planners', 2010, 500.00, 3900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Post-its', 50, 1000.00, 1900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Highlighter', 20, 500.00, 1900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Notebook', 50, 1000.00, 1800);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Grampeadores', 20, 500.00, 1900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Computers', 40, 200000.00, 3900);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Impressoras', 2, 500.00, 2400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Papel', 50, 752.85, 2400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Planners', 20, 500.00, 2400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Post-its', 5000, 1000.00, 2400);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Highlighter', 20, 500.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Notebook', 50, 1000.00, 2500);
INSERT INTO suprimentos (suprimento_nome,quantidade_comprada,custo,escritorio_id) VALUES ('Grampeadores', 10, 500.00, 2500);

INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (1,'Administração',1700);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (2,'Marketing',1800);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (3,'Suprimentos',1700);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (4,'Recursos Humanos',2400);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (5,'Transportes',1500);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (6,'Tecnologia',1400);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (7,'Relações Públicas',2700);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (8,'Vendas',2500);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (9,'Executivo',1700);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (10,'Finanças',1700);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (11,'Contabilidade',1700);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (12,'Biotecnologia',3900);
INSERT INTO departamentos(departamento_id,departamento_nome,escritorio_id) VALUES (13,'Tecnologias Avançadas',1900);

INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (1,'Junior Warehouse Assistant',4200.00,9000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (2,'Gerente de Contabilidade',8200.00,16000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (3,'Assistente Administrativo',3000.00,6000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (4,'CEO',20000.00,40000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (5,'Diretor de Administração, Contabilidade e Recursos',15000.00,30000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (6,'Contabilidade',4200.00,9000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (7,'CFO',8200.00,16000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (8,'Assistente de Recursos',4000.00,9000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (9,'Web Developer',4000.00,10000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (10,'CMO',9000.00,15000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (11,'Representante de Vendas para a América Latina',4000.00,9000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (12,'Relações Públicas',4500.00,10500.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (13,'Purchasing Clerk',2500.00,5500.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (14,'Gerente de Recursos',8000.00,15000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (15,'Gerente de Vendas',10000.00,20000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (16,'Representante de Vendas',6000.00,12000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (17,'Consultor de Vendas',2500.00,5500.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (18,'Estoquista',2000.00,5000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (19,'Gerente de Estoque',5500.00,8500.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (20,'Cientista',14200.00,35000.00);
INSERT INTO cargos(cargo_id,cargo_nome,min_salario,max_salario) VALUES (21,'Assitente de Garantia de Qualidade',6200.00,12000.00);

INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (100,'Steven','Wayne','steven.wayne@momento.org','@4@8@15@16','515.123.4567','1987-06-17',4,24000.00,NULL,9);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (101,'Neena','Kochhar','neena.kochhar@momento.org','@48@15@16','515.123.4568','1989-09-21',5,17000.00,100,9);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (102,'Lex',"T'Challa",'lex.tchalla@momento.org','@4@8@5@16','515.123.4569','1993-01-13',5,17000.00,100,9);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (103,'Alexander','Hunold','alexander.hunold@momento.org','@48@15@16','590.423.4567','1990-01-03',9,9000.00,102,6);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (104,'Bruce','Ernst','bruce.ernst@momento.org','@4@8@15@17','590.423.4568','1991-05-21',9,6000.00,103,6);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (105,'David','Austin','david.austin@momento.org','@4@8@235@16','590.423.4569','1997-06-25',9,4800.00,103,6);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (106,'Valli','Stark','valli.stark@momento.org','@1@2@15@16','590.423.4560','1998-02-05',9,4800.00,103,6);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (107,'Diana','Lorentz','diana.lorentz@momento.org','@0@8@15@16','590.423.5567','1999-02-07',9,4200.00,103,6);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (108,'Nancy','Constantine','nancy.constantine@momento.org','@4@8@15@16','515.124.4569','1994-08-17',9,23980.00,101,13);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (109,'Daniel','Faviet','daniel.faviet@momento.org','@4@15@16','515.124.4169','1994-08-16',6,9000.00,108,10);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (110,'John','Chen','john.chen@momento.org','@4@8@15@12','515.124.4269','1997-09-28',6,8200.00,108,10);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (111,'Ismael','Sciarra','ismael.sciarra@momento.org','@4@8@5@16','515.124.4369','1997-09-30',6,7700.00,108,10);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (112,'Jose Manuel','Urman','jose manuel.urman@momento.org','@@8@15@16','515.124.4469','1998-03-07',6,7800.00,108,10);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (113,'Luis','Popp','luis.popp@momento.org','@4@8@15@16','515.124.4567','1999-12-07',6,6900.00,108,10);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (114,'Den','Raphaely','den.raphaely@momento.org','@4@8@1@16','515.127.4561','1994-12-07',14,11000.00,100,3);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (115,'Normam','Osborn','alexander.osborn@momento.org','@4@8@15@16','515.127.4562','1995-05-18',13,3100.00,114,3);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (116,'Shelli','Baida','shelli.baida@momento.org','@4@8@5@16','515.127.4563','1997-12-24',13,2900.00,114,3);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (117,'Sigal','Tobias','sigal.tobias@momento.org','@4@8@5@16','515.127.4564','1997-07-24',13,2800.00,114,3);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (118,'Guy','Himuro','guy.himuro@momento.org','@4@8@1@16','515.127.4565','1998-11-15',13,2600.00,114,3);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (119,'Karen','Colmenares','karen.colmenares@momento.org','@@8@15@16','515.127.4566','1999-08-10',13,2500.00,114,3);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (120,'Matthew','Weiss','matthew.weiss@momento.org','@4@8@15@16','650.123.1234','1996-07-18',19,8000.00,100,5);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (121,'Adam','Fripp','adam.fripp@momento.org','@4@8@15@16','650.123.2234','1997-04-10',19,8200.00,100,5);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (122,'Payam','Kaufling','payam.kaufling@momento.org','@4@8@15@16','650.123.3234','1995-05-01',19,7900.00,100,5);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (123,'Shanta','Vollman','shanta.vollman@momento.org','@4@8@15@16','650.123.4234','1997-10-10',19,6500.00,100,5);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (126,'Irene','Mikkilineni','irene.mikkilineni@momento.org','@4@8@15@16','650.124.1224','1998-09-28',18,2700.00,120,5);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (145,'John','Russell','john.russell@momento.org','@4@8@15@16',NULL,'1996-10-01',15,14000.00,100,8);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (146,'Karen','Partners','karen.partners@momento.org','@4@8@15@16',NULL,'1997-01-05',15,13500.00,100,8);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (176,'Jonathon','Taylor','jonathon.taylor@momento.org','@4@8@15@16',NULL,'1998-03-24',16,8600.00,100,8);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (177,'Jack','Livingston','jack.livingston@momento.org','@4@8@15@16',NULL,'1998-04-23',16,8400.00,100,8);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (178,'Kimberly','Grant','kimberely.grant@momento.org','@4@8@15@16',NULL,'1999-05-24',16,7000.00,100,8);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (179,'Zatana','Zatara','zatana.zatara@momento.org','@4@8@15@16',NULL,'2000-01-04',20,19650.00,100,13);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (192,'Sarah','Bell','sarah.bell@momento.org','@4@8@15@16','650.501.1876','1996-02-04',17,4000.00,123,5);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (193,'Britney','Everett','britney.everett@momento.org','@4@8@15@16','650.501.2876','1997-03-03',17,3900.00,123,5);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (200,'Jennifer','Whalen','jennifer.whalen@momento.org','@4@8@15@16','515.123.4444','1987-09-17',3,4400.00,101,1);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (201,'Elisabeth','Braddock','michael.braddock@momento.org','@4@8@15@16','515.123.5555','1996-02-17',10,13000.00,100,2);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (202,'Pat','Ferreira','pat.Ferreira@momento.org','@4@8@15@16','603.123.6666','1997-08-17',11,6000.00,201,2);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (203,'Susan','Mavris','susan.mavris@momento.org','@4@8@15@16','515.123.7777','1994-06-07',8,6500.00,101,4);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (204,'Hermann','Baer','hermann.baer@momento.org','@4@8@15@16','515.123.8888','1994-06-07',12,10000.00,101,7);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (205,'Shelley','Higgins','shelley.higgins@momento.org','@4@8@15@16','515.123.8080','1994-06-07',2,12000.00,101,11);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (206,'Susan','Storm','susan.storm@momento.org','@4@8@15@16','515.123.8181','1994-06-07',20,18300.00,205,12);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (207,'Lucius','Fox','lucius.fox@momento.org','@4@8@15@16','515.124.4569','1994-08-17',7,12000.00,101,10);
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) VALUES (207,'Sabrina Portela','Spellman','sabrina.spellman@momento.org','1a2b3c@port','945.368.4569','2024-10-28',20,8000.01,101,10);

INSERT INTO produtos (produto_nome, produto_price) VALUES ("Uniforme do Superman", 300.13);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Fake Batarang", 239.29);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Lança-Teias", 237.19);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Capacete do Homem-Formiga", 289.29);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Nulificador Total", 750.19);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Laço da Verdade", 325.13);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Iron-man MK 5 Helmet", 322.29);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Sabre de Luz (Mace Windu)", 990.29);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Sentinelas do Bolivar Trask", 150.13 );
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Uniforme de Moléculas Instáveis", 158.29);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Laço da Honestidade", 649.29);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("Batarangs Oficiais", 900.29);
INSERT INTO produtos (produto_nome, produto_price) VALUES ("R do Robin", 32.29);

-- Inserting data for vendas
INSERT INTO vendas VALUES (35864200, 3, 19, '2023-06-05', 176);
INSERT INTO vendas VALUES (460333211, 6, 15, '2023-06-10', 177);
INSERT INTO vendas VALUES (23192902, 5, 17, '2023-06-13', 146);
INSERT INTO vendas VALUES (23112902, 6, 13, '2023-06-14', 146);
INSERT INTO vendas VALUES (58923150, 8, 22, '2023-06-15', 178);
INSERT INTO vendas VALUES (11508951, 1, 10, '2023-06-19', 145);
INSERT INTO vendas VALUES (19290129, 9, 14, '2023-06-20', 178);
INSERT INTO vendas VALUES (29290213, 4, 55, '2023-06-21', 145);
INSERT INTO vendas VALUES (12508951, 10, 13, '2023-06-29', 145);
INSERT INTO vendas VALUES (89864008, 12, 3, '2023-07-05', 176);
INSERT INTO vendas VALUES (46073321, 1, 167, '2023-07-10', 176);
INSERT INTO vendas VALUES (14131021, 3, 10, '2023-07-13', 177);
INSERT INTO vendas VALUES (23197502, 5, 19, '2023-07-18', 176);
INSERT INTO vendas VALUES (12519951, 10, 10, '2023-07-20', 145);
INSERT INTO vendas VALUES (23912902, 4, 29, '2023-07-19', 146);
INSERT INTO vendas VALUES (23191302, 11, 8, '2023-07-21', 146);
INSERT INTO vendas VALUES (29923150, 2, 14, '2023-07-29', 178);

-- Data for the table dependentes 
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (1,'Penelope','Wayne','Filha(o)',200);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (2,'Nick','Higgins','Filha(o)',205);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (3,'Ed','Whalen','Filha(o)',200);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (4,'Alice','Wayne','Filha(o)',100);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (5,'Johnny','Kochhar','Filha(o)',101);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (6,'Bette',"T'Challa",'Filha(o)',102);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (7,'Grace','Faviet','Filha(o)',109);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (8,'Matthew','Chen','Filha(o)',110);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (9,'Joe','Sciarra','Filha(o)',111);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (10,'Christian','Urman','Filha(o)',112);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (11,'Zero','Popp','Filha(o)',113);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (12,'John','Constantine','Filha(o)',108);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (13,'Duas','Mavris','Filha(o)',203);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (14,'Vivien','Hunold','Filha(o)',103);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (15,'Cuba','Ernst','Filha(o)',104);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (16,'Fred','Austin','Filha(o)',105);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (17,'Helen','Stark','Filha(o)',106);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (18,'Dan','Lorentz','Filha(o)',107);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (19,'Bob','Braddock ','Filha(o)',201);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (20,'Lucie','Ferreira','Filha(o)',202);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (21,'Kirsten','Baer','Filha(o)',204);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (22,'Harry','Osborn','Filha(o)',115);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (23,'Sandra','Baida','Filha(o)',116);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (24,'Cameron','Tobias','Filha(o)',117);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (25,'Kevin','Himuro','Filha(o)',118);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (26,'Rip','Colmenares','Filha(o)',119);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (27,'Julia','Raphaely','Filha(o)',114);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (28,'Woody','Russell','Filha(o)',145);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (29,'Alec','Partners','Filha(o)',146);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (30,'Sandra','Taylor','Filha(o)',176);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (31,'Franklin','Storm','Filha(o)',206);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (32,'Valeria','Storm','Filha(o)',206);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (33,'Reed','Storm','Cônjuge',206);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (34,'Uma','Mavris','Cônjuge',203);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (35,'Salvadora','Ernst','Cônjuge',104);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (36,'Jennifer','Wayne','Cônjuge',100);
INSERT INTO dependentes(dependente_id,primeiro_nome,sobrenome,relacionamento,funcionario_id) VALUES (37,'Zachary','Zatara','Father',179);

INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 08:00:01', 100);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 08:22:00', 107);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 08:25:33', 106);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 08:41:17', 110);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 08:45:02', 111);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 08:47:22', 177);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Alterou a Senha', '2023-01-15 08:49:22', 177);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 08:51:24', 177);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 09:01:00', 101);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 09:05:00', 114);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Alterou a Senha', '2023-01-15 09:08:22', 206);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 09:18:00', 123);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 09:32:00', 200);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 09:31:24', 204);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 09:45:18', 207);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 09:45:33', 193);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 09:47:01', 121);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 09:51:17', 103);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 09:51:19', 103);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 09:51:19', 192);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 09:52:00', 118);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 10:32:00', 119);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Alterou a Senha', '2023-01-15 11:08:22', 120);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 11:45:29', 122);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 12:00:29', 109);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Solicitou a Alteração de Senha', '2023-01-15 13:13:21', 207);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 14:19:13', 109);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 17:57:19', 203);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 18:32:29', 205);
INSERT INTO audit_log(log_acao, log_ts, funcionario_id) VALUES ('Login', '2023-01-15 19:00:01', 108);
