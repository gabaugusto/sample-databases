-- Loja Portal 9: exportações brutas de catálogo para atividade de qualidade de dados.
-- Execute em uma base de estudo vazia. Os campos de origem são VARCHAR de propósito:
-- a tabela precisa preservar exatamente o que veio nas planilhas.

CREATE DATABASE IF NOT EXISTS loja_9; 
-- Escolho o banco para trabalhar
USE loja_9;

DROP TABLE IF EXISTS catalogo;

CREATE TABLE catalogo (
  registro_id INT PRIMARY KEY,
  lote_origem VARCHAR(40) NOT NULL,
  sku_origem VARCHAR(80),
  produto_origem VARCHAR(180),
  franquia_origem VARCHAR(120),
  categoria_origem VARCHAR(80),
  variante_origem VARCHAR(160),
  preco_origem VARCHAR(80),
  estoque_origem VARCHAR(50),
  atualizado_em_origem VARCHAR(50),
  fornecedor_origem VARCHAR(120),
  condicao_origem VARCHAR(60),
  situacao_origem VARCHAR(60)
);

INSERT INTO importacao_catalogo_raw VALUES
(1,'ERP_OUT_01','SW-001','Sabre de luz azul','Star Wars','arma','edição Jedi','R$ 1.700,00','4','2026-10-01','Jedi Supply','lacrado','ativo'),
(2,'FORN_JEDI_10','SW-001','Sabre de Luz Azul','star wars','Arma','Jedi edition','1700 BRL','4 un.','01/10/2026','JediSupply','Novo','Disponível'),
(3,'FORN_SITH_03','SW-044','Capacete do Vader','Star Wars','acessório','eletrônico, com respirador','R$ 4.500,00','2','2026-10-03','Sith Corp.','lacrado','ativo'),
(4,'ERP_OUT_02','SW-044','Capacete Darth Vader','Star wrs','Acessorio','réplica estática 1:1','4500','2','03/10/26','SithCorp','novo','ativo'),
(5,'FORN_SAURON_01','','Anel do Poder','O Senhor dos Anéis','artefato','réplica licenciada','$ 999.99','??','2026','Sauron Inc.','lacrado','ativo'),
(6,'ERP_OUT_01','LOTR-FAKE-02','One Ring (fake)','Lord of the Rings','artefato','réplica simples','US$ 59.90','30','2022','Mercadinho do Frodo','usado','descontinuado'),
(7,'ERP_OUT_02','PK-001','Pokébola','Pokémon','acessório','vermelha, padrão','R$ 35,00','100','04/2023','','novo','ativo'),
(8,'FORN_KANTO_04','PK-001','Poke Bola','pokemon','Acessorio','padrão - vermelha','35,00','100 un','2023-04-01','Kanto Imports','lacrado','disponivel'),
(9,'ERP_OUT_01','DB-017','Scouter','DragonBallZ','tecnologia','modelo clássico','500¥','17','2023/04/12','Capsule Corp.','novo','ativo'),
(10,'FORN_CAPSULE_02','DB-018','Cápsula hoi-poi','Dragon Ball','tecnologia','kit com 3 unidades','R$60,00','89','03-05-23','Bulma Ltda.','novo','ativo'),
(11,'ERP_OUT_01','MAR-009','Tesseract','Marvel','artefato','versão com suporte','7000 R$','1','2020/09/10','Stark Industries','lacrado','ativo'),
(12,'FORN_APOK_07','DC-003','Caixa Materna','DC Comics','tecnologia','origem desconhecida','∞','0','2019','Apokolips','n/a','ativo'),
(13,'ERP_OUT_02','SW-010','Sabre duplo','star wras','arma','vermelho; estilo Sith','3500 reais','','31/05/23','SithCorp','novo','ativo'),
(14,'FORN_HYRULE_01','ZEL-001','Master Sword','Zelda','arma','réplica de exposição','1.800,00','5','22/03/2023','LinkShop','lacrado','ativo'),
(15,'ERP_OUT_01','ZEL-001','Master Sword (replica)','The Legend of Zelda','armamento','réplica funcional','R$ 1.600,00','3','2022-01-10','Link Shop','novo','ativo'),
(16,'ERP_OUT_02','DC-014','Batarang','DC Comics','arma','tamanho adulto','R$350,00','50','05/07/2023','WayneTech','novo','ativo'),
(17,'FORN_WAYNE_11','DC-014','Batarang','DC','equipamento','adulto','350.00','50','2023-07-05','Wayne Tech','lacrado','disponível'),
(18,'ERP_OUT_01','BEN-001','Omnitrix','Ben10','tecnologia','primeira edição','R$ 300,00','???','07/2021','Bellwood Imports','novo','ativo'),
(19,'FORN_BELLWOOD_03','BEN-002','Omnitrix v2','ben 10','Tecnologia','edição 2','R$400','??','07/2022','BellwoodImports','novo','ativo'),
(20,'FORN_BELLWOOD_03','BEN-003','Omnitrix v3','Ben 10','tecnologia','edição 3','R$500','-2','2023/08/01','BellwoodImports','novo','ativo'),
(21,'ERP_OUT_01','MAR-021','Escudo do Capitão América','Marvel','armadura','réplica em vibranium','R$ 4.500,00','2','2021-09-10','StarkIndustries','lacrado','ativo'),
(22,'FORN_TOYS_09','MAR-022','Escudo Capitão América mini','Marvel Studios','acessório','miniatura infantil','R$ 300,00','20','2021-07-07','Toys4U','novo','ativo'),
(23,'ERP_OUT_01','MAR-023','Escudo do Capitão América (plástico)','MARVEL','Acessorio','brinquedo infantil','R$ 25,00','240','07-11-2023','Toys4U','novo','ativo'),
(24,'ERP_OUT_02','FF-001','Buster Sword','Final Fantasy','arma','Cloud; tamanho adulto','US$ 1,299.00','8 unidades','12-04-22','Shinra','usado','ativo'),
(25,'FORN_SHINRA_05','FF-001','Buster Swrd','Final Fantasy','Arma','réplica de cosplay','USD 1299','8','2022-04-12','Shinra Corp.','novo','ativo'),
(26,'ERP_OUT_01','HP-007','Varinha de Harry','Harry Poter','artefato','madeira e pena de fênix','R$250','42','01.05.2023','Ollivanders','novo','ativo'),
(27,'FORN_OLLIVANDERS_08','HP-007','Varinha Harry Potter','Harry Potter','artefato','pena de fênix e azevinho','R$ 250,00','42','2023-05-01','Ollivanders','lacrado','ativo'),
(28,'ERP_OUT_02','HP-031','Varinha de Bellatrix','Harry Potter','artefato','modelo colecionador','R$ 1.500,00','1','2020/06/01','Ollivanders','novo','ativo'),
(29,'ERP_OUT_02','SW-058','Blaster Imperial','Star Wars','arma','réplica licenciada','US$ 750','20','12/05/21','ImperiumShop','lacrado','ativo'),
(30,'FORN_IMPERIUM_12','SW-058','Blaster imperial','Star Wars','armamento','versão infantil, sem mecanismo','US$750','20','2021-05-12','Imperium Shop','novo','ativo'),
(31,'ERP_OUT_01','SW-060','Capacete Boba Fett','Star Wars','acessório','adulto, edição limitada','R$2.800','2','05-03-2020','SithCorp','lacrado','ativo'),
(32,'ERP_OUT_02','SW-061','Sabre verde Jedi','Star Wrs','arma','verde, lâmina retrátil','1.700','0','31/02/2026','Jedi Supply','novo','reservado'),
(33,'FORN_JEDI_10','SW-062','Sabre amarelo','Star Wars','arma','amarelo, edição sentinela','R$ 3.000,00','1','2026-13-01','JediSupply','novo','ativo'),
(34,'ERP_OUT_02','PK-077','Pokédex','Pokémon','tecnologia','modelo 1.0','200','50','2019-06-01','','novo','ativo'),
(35,'FORN_KANTO_04','PK-078','Pokedex 2.0','Pokemon','tecnologia','modelo atualizado','R$ 250,00','40','2022/07/10','Kanto Imports','novo','ativo'),
(36,'ERP_OUT_01','GOW-001','Lâminas do Caos','God of War','arma','par de lâminas','R$ 3.000,00','1','2023/09/01','Kratos Weapons','lacrado','ativo'),
(37,'ERP_OUT_02','GOW-001','Espada do Kratos','God of W ar','arma','uma lâmina; edição promocional','R$3.000','1','2023/09/01','KratosWeapons','novo','ativo'),
(38,'FORN_HYRULE_06','ZEL-008','Escudo Hyliano','Zelda','armadura','azul com triforce dourada','R$ 1.250,00','10','2022-02-10','HyruleCrafts','lacrado','ativo'),
(39,'ERP_OUT_01','ZEL-008','Escudo Hyliano','Zelda','armadura','azul com Triforce dourada','1250 BRL','10','10/02/2022','Hyrule Crafts','novo','ativo'),
(40,'FORN_SAURON_01','LOTR-001','Cajado de Gandalf','O Senhor dos Aneis','artefato','madeira de exposição','US$ 1,200.00','1','2021/07/01','White Council','usado','ativo'),
(41,'ERP_OUT_02','LOTR-001','Cajado Gandalf','Lord of the Rings','artefato','madeira de exposição','1200 USD','1','2021-07-01','White Council','usado','ativo'),
(42,'ERP_OUT_01','DB-019','Cápsula Hoi-Poi','Dragon Ball Z','tecnologia','unidade avulsa','R$ 60,00','89','03/05/2023','Bulma Ltda','novo','ativo'),
(43,'FORN_CAPSULE_02','DB-019','Cápsula Hoi-Poi','Dragon Ball Z','tecnologia','kit com três cápsulas','R$ 60,00','89','03/05/2023','Bulma Ltda','novo','ativo'),
(44,'ERP_OUT_01','MAR-090','Manopla do Infinito','Marvel','artefato','réplica licenciada; pedras não inclusas','R$ 5.000,00','1','2021-06-10','StarkIndustries','lacrado','ativo'),
(45,'ERP_OUT_01','SW-090','Sabre de luz laranja','Star Wars','arma','lâmina laranja','R$ 3.300,00','1','2021-08-10','JediSupply','lacrado','ativo'),
(46,'FORN_JEDI_10','SW-090','Sabre laranja Jedi','Star Wrs','arma','lâmina amarela','R$ 3.300,00','1','10/08/2021','Jedi Supply','lacrado','ativo'),
(47,'ERP_OUT_01','DC-099','Batarang mini','DC Comics','arma','miniatura infantil','R$150','50','2022-03-10','WayneTech','novo','ativo'),
(48,'ERP_OUT_02','DC-100','Batarang mini','DC Comics','arma','miniatura infantil','R$ 150,00','50','2022-03-10','WayneTech','novo','ativo'),
(49,'FORN_HYRULE_06','ZEL-010','Master Sword','Zelda','arma','réplica de exposição','R$ 1.800,00','5','2026-10-04','LinkShop','lacrado','ativo'),
(50,'ERP_OUT_01','SW-101','Sabre de luz azul','Star Wars','arma','edição Jedi','R$ 1.700,00','-','2026-10-04','Jedi Supply','lacrado','ativo');
