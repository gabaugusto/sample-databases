-- Momento: base relacional para atividades de SQL e ETL.
-- Requer MySQL 8.0+. O script usa o schema isolado momento_aula.
-- Execute em um schema vazio. O script não apaga nem recria tabelas existentes.

DROP DATABASE IF EXISTS momento;
CREATE DATABASE IF NOT EXISTS momento;
USE momento;

CREATE TABLE regioes (
  regiao_id INT PRIMARY KEY,
  regiao_nome VARCHAR(48) NOT NULL UNIQUE
);

CREATE TABLE paises (
  pais_id CHAR(2) PRIMARY KEY,
  pais_nome VARCHAR(64) NOT NULL,
  regiao_id INT NOT NULL,
  CONSTRAINT fk_paises_regiao FOREIGN KEY (regiao_id) REFERENCES regioes(regiao_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE escritorios (
  escritorio_id INT PRIMARY KEY,
  escritorio_nome VARCHAR(64) NOT NULL UNIQUE,
  endereco VARCHAR(100) NOT NULL,
  cep VARCHAR(16),
  cidade VARCHAR(64) NOT NULL,
  estado_provincia VARCHAR(64) NOT NULL,
  pais_id CHAR(2) NOT NULL,
  CONSTRAINT fk_escritorios_pais FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE departamentos (
  departamento_id INT PRIMARY KEY,
  departamento_nome VARCHAR(64) NOT NULL,
  educacional BOOLEAN DEFAULT 0,
  escritorio_id INT NOT NULL,
  UNIQUE (departamento_nome, escritorio_id),
  CONSTRAINT fk_departamentos_escritorio FOREIGN KEY (escritorio_id) REFERENCES escritorios(escritorio_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE cargos (
  cargo_id INT PRIMARY KEY,
  cargo_nome VARCHAR(80) NOT NULL UNIQUE,
  min_salario DECIMAL(10,2) NOT NULL,
  max_salario DECIMAL(10,2) NOT NULL,
  CHECK (min_salario <= max_salario)
);

-- Tabelas de domínio: evitam valores livres e repetidos nas tabelas operacionais.
CREATE TABLE status_funcionario (
  status_funcionario_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE status_venda (
  status_venda_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE canais_venda (
  canal_venda_id TINYINT PRIMARY KEY,
  nome VARCHAR(24) NOT NULL UNIQUE
);

CREATE TABLE acoes_etl (
  acao_etl_id TINYINT PRIMARY KEY,
  nome VARCHAR(24) NOT NULL UNIQUE
);
CREATE TABLE modulos_auditoria (
  modulo_auditoria_id TINYINT PRIMARY KEY,
  nome VARCHAR(30) NOT NULL UNIQUE
);
CREATE TABLE status_auditoria (
  status_auditoria_id TINYINT PRIMARY KEY,
  nome VARCHAR(20) NOT NULL UNIQUE
);
CREATE TABLE tipos_movimentacao_estoque (
  tipo_movimentacao_estoque_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE funcionarios (
  funcionario_id INT PRIMARY KEY,
  primeiro_nome VARCHAR(48) NOT NULL,
  sobrenome VARCHAR(48) NOT NULL,
  email VARCHAR(128) NOT NULL UNIQUE,
  telefone VARCHAR(24),
  data_contratacao DATE NOT NULL,
  cargo_id INT NOT NULL,
  salario DECIMAL(10,2) NOT NULL,
  moeda_salario CHAR(3) NOT NULL DEFAULT 'USD',
  gerente_id INT,
  departamento_id INT NOT NULL,
  status_funcionario_id TINYINT NOT NULL DEFAULT 1,
  CHECK (salario >= 500),
  CONSTRAINT fk_funcionarios_cargo FOREIGN KEY (cargo_id) REFERENCES cargos(cargo_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_funcionarios_departamento FOREIGN KEY (departamento_id) REFERENCES departamentos(departamento_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_funcionarios_gerente FOREIGN KEY (gerente_id) REFERENCES funcionarios(funcionario_id)
    ON UPDATE CASCADE 
    ON DELETE SET NULL,
  CONSTRAINT fk_funcionario_status FOREIGN KEY (status_funcionario_id) REFERENCES status_funcionario(status_funcionario_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE dependentes (
  dependente_id INT PRIMARY KEY,
  primeiro_nome VARCHAR(48) NOT NULL,
  sobrenome VARCHAR(48) NOT NULL,
  relacionamento VARCHAR(24) NOT NULL,
  funcionario_id INT NOT NULL,
  CONSTRAINT fk_dependentes_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE suprimentos (
  suprimento_id INT PRIMARY KEY,
  referencia_compra VARCHAR(32) NOT NULL UNIQUE,
  suprimento_nome VARCHAR(100) NOT NULL,
  quantidade_estoque INT NOT NULL,
  custo_unitario DECIMAL(10,2) NOT NULL,
  moeda CHAR(3) NOT NULL DEFAULT 'USD',
  data_compra DATE NOT NULL,
  escritorio_id INT NOT NULL,
  CHECK (quantidade_estoque > 0),
  CHECK (custo_unitario >= 0),
  CONSTRAINT fk_suprimentos_escritorio FOREIGN KEY (escritorio_id) REFERENCES escritorios(escritorio_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE categorias_produto (
  categoria_id INT PRIMARY KEY,
  categoria_nome VARCHAR(64) NOT NULL UNIQUE
);

CREATE TABLE produtos (
  produto_id INT PRIMARY KEY,
  sku VARCHAR(32) NOT NULL UNIQUE,
  produto_nome VARCHAR(125) NOT NULL,
  categoria_id INT NOT NULL,
  preco_catalogo DECIMAL(10,2) NOT NULL,
  moeda CHAR(3) NOT NULL DEFAULT 'USD',
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  CHECK (preco_catalogo >= 0),
  CONSTRAINT fk_produtos_categoria FOREIGN KEY (categoria_id) REFERENCES categorias_produto(categoria_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE status_cliente (
  status_cliente_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE formas_pagamento (
  forma_pagamento_id TINYINT PRIMARY KEY,
  nome VARCHAR(24) NOT NULL UNIQUE
);

CREATE TABLE status_pagamento (
  status_pagamento_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE status_entrega (
  status_entrega_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE niveis_curso (
  nivel_curso_id TINYINT PRIMARY KEY,
  nome VARCHAR(24) NOT NULL UNIQUE
);

CREATE TABLE status_matricula (
  status_matricula_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE tipos_vinculo (
  tipo_vinculo_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE status_vinculo (
  status_vinculo_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE status_aluno (
  status_aluno_id TINYINT PRIMARY KEY,
  nome VARCHAR(16) NOT NULL UNIQUE
);

-- Relacionamento comercial: o cliente pode existir sem compras e vendas antigas
-- permanecem válidas enquanto não houver identificação do consumidor.
CREATE TABLE clientes (
  cliente_id INT PRIMARY KEY,
  nome VARCHAR(128) NOT NULL,
  email VARCHAR(128) NOT NULL UNIQUE,
  telefone VARCHAR(24),
  data_cadastro DATE NOT NULL,
  consentimento_marketing BOOLEAN NOT NULL DEFAULT FALSE,
  status_cliente_id TINYINT NOT NULL DEFAULT 1,
  CONSTRAINT fk_cliente_status FOREIGN KEY (status_cliente_id) REFERENCES status_cliente(status_cliente_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE enderecos_cliente (
  endereco_cliente_id INT PRIMARY KEY,
  cliente_id INT NOT NULL,
  tipo VARCHAR(16) NOT NULL,
  endereco VARCHAR(100) NOT NULL,
  cidade VARCHAR(64) NOT NULL,
  estado_provincia VARCHAR(64),
  cep VARCHAR(16),
  pais_id CHAR(2) NOT NULL,
  principal BOOLEAN NOT NULL DEFAULT FALSE,
  CHECK (tipo IN ('ENTREGA', 'COBRANCA')),
  CONSTRAINT fk_endereco_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
  CONSTRAINT fk_endereco_pais FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE fornecedores (
  fornecedor_id INT PRIMARY KEY,
  razao_social VARCHAR(128) NOT NULL,
  email VARCHAR(128),
  telefone VARCHAR(24),
  pais_id CHAR(2) NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_fornecedor_pais FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE fornecedores_produtos (
  fornecedor_id INT NOT NULL,
  produto_id INT NOT NULL,
  sku_fornecedor VARCHAR(48),
  custo_unitario DECIMAL(10,2) NOT NULL,
  moeda CHAR(3) NOT NULL,
  PRIMARY KEY (fornecedor_id, produto_id),
  CHECK (custo_unitario >= 0),
  CONSTRAINT fk_fp_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(fornecedor_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_fp_produto FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE movimentacoes_estoque (
  movimentacao_id INT PRIMARY KEY,
  produto_id INT NOT NULL,
  escritorio_id INT NOT NULL,
  data_movimentacao DATETIME NOT NULL,
  tipo_movimentacao_estoque_id TINYINT NOT NULL,
  quantidade INT NOT NULL,
  referencia VARCHAR(48),
  CHECK (quantidade > 0),
  CONSTRAINT fk_movimento_produto FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_movimento_escritorio FOREIGN KEY (escritorio_id) REFERENCES escritorios(escritorio_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_movimento_tipo FOREIGN KEY (tipo_movimentacao_estoque_id) REFERENCES tipos_movimentacao_estoque(tipo_movimentacao_estoque_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE historico_precos_produto (
  preco_id INT PRIMARY KEY,
  produto_id INT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  moeda CHAR(3) NOT NULL,
  inicio_vigencia DATE NOT NULL,
  fim_vigencia DATE,
  CHECK (preco >= 0),
  CHECK (fim_vigencia IS NULL OR fim_vigencia >= inicio_vigencia),
  CONSTRAINT fk_historico_preco_produto FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

-- Área de pouso ETL: importar o CSV sem converter os valores na entrada.
-- As tabelas stg_vendas_csv e etl_rejeicoes ficam vazias de propósito; serão usadas no desafio ETL.

CREATE TABLE stg_vendas_csv (
  source_row_id INT PRIMARY KEY,
  lote_origem VARCHAR(32) NOT NULL,
  pedido_ref VARCHAR(48),
  item_seq VARCHAR(20),
  data_venda_raw VARCHAR(40),
  locale_origem VARCHAR(20),
  sku_raw VARCHAR(40),
  quantidade_raw VARCHAR(24),
  preco_unitario_raw VARCHAR(48),
  moeda_raw VARCHAR(12),
  email_vendedor_raw VARCHAR(128),
  canal_raw VARCHAR(32),
  status_raw VARCHAR(32)
);

CREATE TABLE etl_rejeicoes (
  rejeicao_id INT PRIMARY KEY,
  source_row_id INT NOT NULL,
  campo VARCHAR(48) NOT NULL,
  valor_original VARCHAR(128),
  motivo VARCHAR(255) NOT NULL,
  acao_etl_id TINYINT NOT NULL DEFAULT 1,
  CONSTRAINT fk_rejeicoes_staging FOREIGN KEY (source_row_id) REFERENCES stg_vendas_csv(source_row_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_rejeicao_acao FOREIGN KEY (acao_etl_id) REFERENCES acoes_etl(acao_etl_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE vendas (
  venda_id INT PRIMARY KEY,
  referencia_origem VARCHAR(48) UNIQUE,
  data_venda DATE NOT NULL,
  cliente_id INT,
  funcionario_id INT NOT NULL,
  canal_venda_id TINYINT NOT NULL,
  status_venda_id TINYINT NOT NULL,
  CONSTRAINT fk_vendas_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_vendas_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
    ON UPDATE CASCADE 
    ON DELETE SET NULL,
  CONSTRAINT fk_venda_canal FOREIGN KEY (canal_venda_id) REFERENCES canais_venda(canal_venda_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_venda_status FOREIGN KEY (status_venda_id) REFERENCES status_venda(status_venda_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);


CREATE TABLE itens_venda (
  item_venda_id INT PRIMARY KEY,
  venda_id INT NOT NULL,
  numero_item INT NOT NULL,
  produto_id INT NOT NULL,
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  moeda CHAR(3) NOT NULL,
  source_row_id INT UNIQUE,
  UNIQUE (venda_id, numero_item),
  CHECK (quantidade > 0),
  CHECK (preco_unitario >= 0),
  CONSTRAINT fk_itens_venda_venda FOREIGN KEY (venda_id) REFERENCES vendas(venda_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_itens_venda_produto FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_itens_venda_staging FOREIGN KEY (source_row_id) REFERENCES stg_vendas_csv(source_row_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE audit_log (
  log_id INT PRIMARY KEY,
  log_acao VARCHAR(100) NOT NULL,
  log_ts DATETIME NOT NULL,
  modulo_auditoria_id TINYINT NOT NULL,
  status_auditoria_id TINYINT NOT NULL,
  log_origem VARCHAR(64),
  log_detalhes VARCHAR(255),
  funcionario_id INT,
  CONSTRAINT fk_audit_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id)
    ON UPDATE CASCADE 
    ON DELETE SET NULL,
  CONSTRAINT fk_audit_modulo FOREIGN KEY (modulo_auditoria_id) REFERENCES modulos_auditoria(modulo_auditoria_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_audit_status FOREIGN KEY (status_auditoria_id) REFERENCES status_auditoria(status_auditoria_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE pagamentos (
  pagamento_id INT PRIMARY KEY,
  venda_id INT NOT NULL,
  data_pagamento DATETIME,
  valor DECIMAL(10,2) NOT NULL,
  moeda CHAR(3) NOT NULL,
  forma_pagamento_id TINYINT NOT NULL,
  status_pagamento_id TINYINT NOT NULL,
  referencia_transacao VARCHAR(64) UNIQUE,
  CHECK (valor >= 0),
  CONSTRAINT fk_pagamento_venda FOREIGN KEY (venda_id) REFERENCES vendas(venda_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_pagamento_forma FOREIGN KEY (forma_pagamento_id) REFERENCES formas_pagamento(forma_pagamento_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_pagamento_status FOREIGN KEY (status_pagamento_id) REFERENCES status_pagamento(status_pagamento_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE entregas (
  entrega_id INT PRIMARY KEY,
  venda_id INT NOT NULL UNIQUE,
  endereco_cliente_id INT,
  transportadora VARCHAR(64),
  codigo_rastreio VARCHAR(64),
  data_postagem DATE,
  data_entrega DATE,
  status_entrega_id TINYINT NOT NULL,
  CHECK (data_entrega IS NULL OR data_postagem IS NULL OR data_entrega >= data_postagem),
  CONSTRAINT fk_entrega_venda FOREIGN KEY (venda_id) REFERENCES vendas(venda_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_entrega_endereco FOREIGN KEY (endereco_cliente_id) REFERENCES enderecos_cliente(endereco_cliente_id)
    ON UPDATE CASCADE 
    ON DELETE SET NULL,
  CONSTRAINT fk_entrega_status FOREIGN KEY (status_entrega_id) REFERENCES status_entrega(status_entrega_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

-- Núcleo educacional: alunos não são funcionários; a ligação acontece apenas
-- quando há uma oportunidade formal de estágio ou contratação.
CREATE TABLE cursos (
  curso_id INT PRIMARY KEY,
  curso_nome VARCHAR(120) NOT NULL UNIQUE,
  carga_horaria INT NOT NULL,
  nivel_curso_id TINYINT NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  CHECK (carga_horaria > 0),
  CONSTRAINT fk_curso_nivel FOREIGN KEY (nivel_curso_id) REFERENCES niveis_curso(nivel_curso_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE turmas (
  turma_id INT PRIMARY KEY,
  curso_id INT NOT NULL,
  codigo VARCHAR(32) NOT NULL UNIQUE,
  data_inicio DATE NOT NULL,
  data_fim DATE NOT NULL,
  capacidade INT NOT NULL,
  professor_funcionario_id INT NOT NULL,
  escritorio_id INT NOT NULL,
  CHECK (data_fim >= data_inicio),
  CHECK (capacidade > 0),
  CONSTRAINT fk_turma_curso FOREIGN KEY (curso_id) REFERENCES cursos(curso_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_turma_professor FOREIGN KEY (professor_funcionario_id) REFERENCES funcionarios(funcionario_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_turma_escritorio FOREIGN KEY (escritorio_id) REFERENCES escritorios(escritorio_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE alunos (
  aluno_id INT PRIMARY KEY,
  nome VARCHAR(128) NOT NULL,
  email VARCHAR(128) NOT NULL UNIQUE,
  data_nascimento DATE,
  data_cadastro DATE NOT NULL,
  status_aluno_id TINYINT NOT NULL DEFAULT 1,
  CONSTRAINT fk_aluno_status FOREIGN KEY (status_aluno_id) REFERENCES status_aluno(status_aluno_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE matriculas (
  matricula_id INT PRIMARY KEY,
  aluno_id INT NOT NULL,
  turma_id INT NOT NULL,
  data_matricula DATE NOT NULL,
  status_matricula_id TINYINT NOT NULL,
  nota_final DECIMAL(5,2),
  certificado_emitido BOOLEAN NOT NULL DEFAULT FALSE,
  UNIQUE (aluno_id, turma_id),
  CHECK (nota_final IS NULL OR (nota_final >= 0 AND nota_final <= 100)),
  CONSTRAINT fk_matricula_aluno FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_matricula_turma FOREIGN KEY (turma_id) REFERENCES turmas(turma_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_matricula_status FOREIGN KEY (status_matricula_id) REFERENCES status_matricula(status_matricula_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE bolsas (
  bolsa_id INT PRIMARY KEY,
  aluno_id INT NOT NULL,
  curso_id INT NOT NULL,
  percentual_desconto DECIMAL(5,2) NOT NULL,
  criterio VARCHAR(255) NOT NULL,
  data_concessao DATE NOT NULL,
  CHECK (percentual_desconto > 0 AND percentual_desconto <= 100),
  CONSTRAINT fk_bolsa_aluno FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_bolsa_curso FOREIGN KEY (curso_id) REFERENCES cursos(curso_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);

CREATE TABLE vinculos_talentos (
  vinculo_id INT PRIMARY KEY,
  aluno_id INT NOT NULL,
  funcionario_id INT,
  departamento_id INT NOT NULL,
  tipo_vinculo_id TINYINT NOT NULL,
  data_inicio DATE NOT NULL,
  data_fim DATE,
  status_vinculo_id TINYINT NOT NULL,
  CHECK (data_fim IS NULL OR data_fim >= data_inicio),
  CONSTRAINT fk_vinculo_aluno FOREIGN KEY (aluno_id) REFERENCES alunos(aluno_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_vinculo_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionarios(funcionario_id)
    ON UPDATE CASCADE 
    ON DELETE SET NULL,
  CONSTRAINT fk_vinculo_departamento FOREIGN KEY (departamento_id) REFERENCES departamentos(departamento_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_vinculo_tipo FOREIGN KEY (tipo_vinculo_id) REFERENCES tipos_vinculo(tipo_vinculo_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  CONSTRAINT fk_vinculo_status FOREIGN KEY (status_vinculo_id) REFERENCES status_vinculo(status_vinculo_id)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);


-- Inserções

INSERT INTO status_funcionario (status_funcionario_id, nome) VALUES 
  (1, 'ATIVO'), (2, 'AFASTADO'), (3, 'INATIVO');

INSERT INTO status_venda (status_venda_id, nome) VALUES
  (1, 'CONCLUIDA'), (2, 1), (3, 'CANCELADA');

INSERT INTO canais_venda (canal_venda_id, nome) VALUES
  (1, 'LOJA'), (2, 'WEB'), (3, 'APP'), (4, 'MARKETPLACE'), (5, 'B2B');

INSERT INTO acoes_etl (acao_etl_id, nome) VALUES
  (1, 'REVISAR'), (2, 'REJEITAR'), (3, 'DUPLICATA');
INSERT INTO modulos_auditoria (modulo_auditoria_id, nome) VALUES
  (1, 'PRODUTOS'), (2, 'FINANCEIRO'), (3, 'SUPRIMENTOS'), (4, 'SEGURANCA'), (5, 'VENDAS'), (6, 'AUTENTICACAO');
INSERT INTO status_auditoria (status_auditoria_id, nome) VALUES
  (1, 'REGISTRADO'), (2, 'SUCESSO'), (3, 'FALHA'), (4, 'BLOQUEADO');
INSERT INTO tipos_movimentacao_estoque (tipo_movimentacao_estoque_id, nome) VALUES
  (1, 'ENTRADA'), (2, 'SAIDA'), (3, 'AJUSTE');

INSERT INTO status_cliente (status_cliente_id, nome) VALUES
  (1, 'ATIVO'), (2, 'INATIVO');

INSERT INTO formas_pagamento (forma_pagamento_id, nome) VALUES
  (1, 'CARTAO'), (2, 'PIX'), (3, 'BOLETO'), (4, 'DINHEIRO'), (5, 'TRANSFERENCIA');

INSERT INTO status_pagamento (status_pagamento_id, nome) VALUES
  (1, 1), (2, 'APROVADO'), (3, 'RECUSADO'), (4, 'ESTORNADO');

INSERT INTO status_entrega (status_entrega_id, nome) VALUES
  (1, 1), (2, 'ENVIADA'), (3, 3), (4, 'DEVOLVIDA');

INSERT INTO niveis_curso (nivel_curso_id, nome) VALUES
  (1, 'INTRODUTORIO'), (2, 'INTERMEDIARIO'), (3, 'AVANCADO');

INSERT INTO status_matricula (status_matricula_id, nome) VALUES
  (1, 'ATIVA'), (2, 'CANCELADA'), (3, 'CONCLUIDA');

INSERT INTO tipos_vinculo (tipo_vinculo_id, nome) VALUES
  (1, 'ESTAGIO'), (2, 'CONTRATACAO');

INSERT INTO status_vinculo (status_vinculo_id, nome) VALUES
  (1, 'ATIVO'), (2, 'ENCERRADO'), (3, 'CANCELADO');

INSERT INTO status_aluno (status_aluno_id, nome) VALUES
  (1, 'ATIVO'), (2, 'INATIVO'), (3, 'FORMADO');

INSERT INTO regioes (regiao_id, regiao_nome) VALUES
  (1, 'América do Norte'),
  (2, 'América do Sul'),
  (3, 'Europa'),
  (4, 'Ásia'),
  (5, 'África'),
  (6, 'Oceania'),
  (7, 'Universos'),
  (8, 'Europa Mágica'),
  (9, 'Américas Encantadas'),
  (10, 'Ásia Mística');

INSERT INTO paises (pais_id, pais_nome, regiao_id) VALUES
  ('US', 'Estados Unidos', 1),
  ('CA', 'Canadá', 1),
  ('MX', 'México', 1),
  ('AR', 'Argentina', 2),
  ('BR', 'Brasil', 2),
  ('BM', 'Brasil Bruxo', 9),
  ('CL', 'Chile', 2),
  ('CO', 'Colômbia', 2),
  ('PE', 'Peru', 2),
  ('GB', 'Reino Unido', 3),
  ('GM', 'Reino dos Mágos Unidos', 8),
  ('FR', 'França', 3),
  ('FM', 'França Mágica', 8),
  ('DE', 'Alemanha', 3),
  ('IT', 'Itália', 3),
  ('ES', 'Espanha', 3),
  ('PT', 'Portugal', 3),
  ('PM', 'Portugal Bruxo', 8),
  ('NL', 'Países Baixos', 3),
  ('CH', 'Suíça', 3),
  ('SE', 'Suécia', 3),
  ('NO', 'Noruega', 3),
  ('JP', 'Japão', 4),
  ('JM', 'Japão Místico', 10),
  ('CN', 'China', 4),
  ('IN', 'Índia', 4),
  ('SG', 'Singapura', 4),
  ('KR', 'Coreia do Sul', 4),
  ('IL', 'Israel', 4),
  ('EG', 'Egito', 5),
  ('NG', 'Nigéria', 5),
  ('ZA', 'África do Sul', 5),
  ('ZM', 'Zâmbia', 5),
  ('ZW', 'Zimbábue', 5),
  ('AU', 'Austrália', 6),
  ('NZ', 'Nova Zelândia', 6),
  ('KK', 'Krakoa', 7),
  ('LE', 'Latvéria', 7),
  ('MI', 'Markóvia', 7),
  ('QU', 'Qurac', 7),
  ('TY', 'Themyscira', 7),
  ('WA', 'Wakanda', 7),
  ('UM', 'Estados Unidos Arcanos', 9);

INSERT INTO escritorios (escritorio_id, escritorio_nome, endereco, cep, cidade, estado_provincia, pais_id) VALUES
  (1300, 'Torre de Paris', 'Avenue des Sorciers, 42', '75001', 'Paris', 'Île-de-France', 'FM'),
  (1400, 'Wayne Offices', '2014 Jabberwocky Rd', '26192', 'Gotham', 'New York', 'US'),
  (1500, 'Stark Tower', '2011 Interiors Blvd', '94080', 'South San Francisco', 'California', 'US'),
  (1700, 'Sala Winter', '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
  (1800, 'Arkham Base', '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
  (2400, 'Shuri''s Palace', '8204 Arthur St', NULL, 'Birnin Zana', 'Wakanda', 'WA'),
  (2500, 'Umbrella Corp', 'Magdalen Centre', 'OX9 9ZB', 'Oxford', 'England', 'GB'),
  (2600, 'Campus de Lisboa', 'Travessa dos Feitiços, 7', '1100-001', 'Lisboa', 'Lisboa', 'PM'),
  (2700, 'Archies Mad House', '28 Marienplatz', '80331', 'Munich', 'Bavaria', 'DE'),
  (3900, 'Baxter Building', 'Excelsior Rd. 7031', 'WC2N 5DU', 'London', 'England', 'GB'),
  (1900, 'House of Mystery', 'The Trickster Rd. 42', 'NE1 4LP', 'Newcastle', 'England', 'GB'),
  (2900, 'Daily Planet Bureau', '1 Place du Trocadéro', '75116', 'Paris', 'Île-de-France', 'FR'),
  (2800, 'Verstebona', 'Av. Sayo Yamamoto, 1000', '01310-100', 'São Paulo', 'São Paulo', 'BR'),
  (4500, 'Instituto Rio', 'Alameda dos Magos, 300', '20000-000', 'Rio de Janeiro', 'RJ', 'BM'),
  (5100, 'Tokyo Lab', '1-1 Chiyoda', '100-0001', 'Tokyo', 'Tokyo', 'JP'),
  (3800, 'Paititi Operations', 'Lara Lara', '2000', 'Paititi', 'Macchu Pichu', 'PE'),
  (3100, 'Cape Town Studio', '10 Heerengracht St', '8001', 'Cape Town', 'Western Cape', 'ZA'),
  (3200, 'Koboa Koboa', 'Av. Corrientes 1000', 'C1043', 'Buenos Aires', 'Buenos Aires', 'AR'),
  (5000, 'Castelo Principal', 'Rua do Beco Diagonal, 1', 'HP1 1AA', 'Hogsmeade', 'Escócia', 'GM'),
  (3000, 'Castelo Encantado', 'Ghibli Shrine Rd, 5', '603-8047', 'Kyoto', 'Kyoto', 'JM');

INSERT INTO departamentos (departamento_id, departamento_nome, educacional, escritorio_id) VALUES
  (1, 'Administração Executiva', 0, 1700),
  (2, 'Marketing', 0, 1800),
  (3, 'Recursos Humanos', 0, 1700),
  (4, 'Recursos Humanos', 0, 2400),
  (5, 'Logística', 0, 1500),
  (6, 'Tecnologia da Informação', 0, 1400),
  (7, 'Relações Públicas', 0, 2700),
  (8, 'Vendas', 0, 2500),
  (9, 'Executivo', 0, 1700),
  (10, 'Finanças', 0, 1700),
  (11, 'Contabilidade', 0, 1700),
  (12, 'Biotecnologia', 0, 3900),
  (13, 'Tecnologias Avançadas', 0, 1900),
  (14, 'Dados e Inteligência', 0, 1400),
  (15, 'Experiência do Cliente', 0, 1800),
  (16, 'Operações LATAM', 0, 2800),
  (17, 'Segurança da Informação', 0, 1500),
  (18, 'Pesquisa e Desenvolvimento', 0, 2400),
  (19, 'Comércio Digital', 0, 2900),
  (20, 'Operações APAC', 0, 3000),
  (21, 'Criação de Conteúdo', 0, 2600),
  (22, 'Operações África', 0, 3100),
  (23, 'Poções', 1, 1300),
  (24, 'Transfiguração', 1, 5100),
  (25, 'Projeções Astrais', 1, 4500),
  (26, 'Criaturas Mágicas', 1, 3200),
  (27, 'Biblioteca Arcana', 1, 5000),
  (28, 'Administração Educacional', 1, 3000),
  (29, 'Astronomia', 1, 2800),
  (30, 'Herbologia', 1, 3800);


INSERT INTO cargos (cargo_id, cargo_nome, min_salario, max_salario) VALUES
  (1, 'Assistente de Armazém', 4200, 9000),
  (2, 'Gerente de Contabilidade', 8200, 16000),
  (3, 'Assistente Administrativo', 3000, 6000),
  (4, 'CEO', 20000, 40000),
  (5, 'Diretor de Operações', 15000, 30000),
  (6, 'Contador', 4200, 9000),
  (7, 'CFO', 12000, 24000),
  (8, 'Assistente de Recursos Humanos', 4000, 9000),
  (9, 'Desenvolvedor Web', 4000, 10000),
  (10, 'CMO', 9000, 18000),
  (11, 'Representante de Vendas LATAM', 4000, 9000),
  (12, 'Relações Públicas', 4500, 10500),
  (13, 'Assistente de Compras', 2500, 5500),
  (14, 'Gerente de Recursos Humanos', 8000, 15000),
  (15, 'Gerente de Vendas', 10000, 20000),
  (16, 'Representante de Vendas', 6000, 12000),
  (17, 'Consultor de Vendas', 2500, 5500),
  (18, 'Estoquista', 2000, 5000),
  (19, 'Gerente de Estoque', 5500, 8500),
  (20, 'Cientista de Dados', 14200, 35000),
  (21, 'Analista de Qualidade', 6200, 12000),
  (22, 'Analista Financeiro', 5000, 11000),
  (23, 'Designer de Produto', 5000, 12000),
  (24, 'Especialista de Segurança', 8000, 18000),
  (25, 'Gerente de Operações', 9000, 19000),
  (26, 'Senior Web Developer', 7000, 16000),
  (27, 'Analista de Atendimento', 3500, 8000),
  (28, 'Especialista de Marketing Digital', 5000, 13000),
  (29, 'Diretor', 12000.00, 20000.00),
  (30, 'Professor Titular', 7000.00, 12000.00),
  (31, 'Professor Assistente', 4500.00, 7000.00),
  (32, 'Mestre de Poções', 6000.00, 9500.00),
  (33, 'Guardião', 3000.00, 5000.00),
  (34, 'Bibliotecário Arcano', 3500.00, 5500.00),
  (35, 'Tratador de Criaturas', 3200.00, 5200.00),
  (36, 'Astrônomago', 5000.00, 8000.00),
  (37, 'Herbólogo', 4000.00, 6500.00),
  (38, 'Oficial de Segurança Biológia', 6500.00, 11000.00),
  (39, 'Secretário Administrativo', 2800.00, 4200.00),
  (40, 'Aprendiz', 1800.00, 2800.00);

INSERT INTO funcionarios 
  (funcionario_id, primeiro_nome, sobrenome, email, telefone, data_contratacao, cargo_id, salario, moeda_salario, gerente_id, departamento_id, status_funcionario_id) 
  VALUES
  (100, 'Madeleine', 'Prior', 'madeleine.prior@momento.org', NULL, '1987-03-23', 4, 22343.22, 'USD', NULL, 9, 1),
  (101, 'Neena', 'Kochhar', 'neena.kochhar@momento.org', '+1-555-201-1001', '1987-08-17', 5, 18749.91, 'USD', 100, 9, 1),
  (102, 'Lex', 'T.Challa', 'lex.tchalla@momento.org', '+1-555-202-1002', '1988-02-08', 5, 25976.13, 'USD', 100, 9, 1),
  (103, 'Alexander', 'Hunold', 'alexander.hunold@momento.org', '+1-555-203-1003', '1988-10-27', 9, 8371.81, 'USD', 102, 6, 1),
  (104, 'Bruce', 'Ernst', 'bruce.ernst@momento.org', '+1-555-204-1004', '1989-02-22', 9, 6000.0, 'USD', 100, 6, 1),
  (105, 'David', 'Austin', 'david.austin@momento.org', '+1-555-205-1005', '1989-08-26', 9, 4684.06, 'USD', 101, 6, 1),
  (106, 'Valli', 'Stark', 'valli.stark@momento.org', '+1-555-206-1006', '1990-05-07', 9, 7581.51, 'USD', 104, 6, 1),
  (107, 'Diana', 'Lorentz', 'diana.lorentz@momento.org', NULL, '1990-10-08', 9, 8231.31, 'USD', 105, 6, 1),
  (108, 'Nancy', 'Constantine', 'nancy.constantine@momento.org', '+1-555-208-1008', '1991-06-02', 26, 10799.82, 'USD', 107, 13, 1),
  (109, 'Daniel', 'Faviet', 'daniel.faviet@momento.org', '+1-555-209-1009', '1991-12-18', 6, 5601.86, 'USD', 100, 10, 1),
  (110, 'John', 'Chen', 'john.chen@momento.org', '+1-555-210-1010', '1992-05-04', 6, 7491.63, 'USD', 105, 10, 1),
  (111, 'Ismael', 'Sciarra', 'ismael.sciarra@momento.org', '+1-555-211-1011', '1992-11-28', 6, 5049.66, 'USD', 105, 10, 1),
  (112, 'Jose Manuel', 'Urman', 'jose.manuel.urman@momento.org', '+1-555-212-1012', '1993-05-18', 6, 4767.36, 'USD', 101, 10, 1),
  (113, 'Luis', 'Popp', 'luis.popp@momento.org', '+1-555-213-1013', '1993-12-29', 6, 8163.72, 'USD', 109, 10, 1),
  (114, 'Den', 'Raphaely', 'den.raphaely@momento.org', NULL, '1994-06-28', 14, 13557.76, 'USD', 100, 3, 1),
  (115, 'Norman', 'Osborn', 'norman.osborn@momento.org', '+1-555-215-1015', '1995-02-01', 13, 4097.82, 'USD', 114, 3, 1),
  (116, 'Shelli', 'Baida', 'shelli.baida@momento.org', '+1-555-216-1016', '1995-08-03', 13, 2862.76, 'USD', 109, 3, 1),
  (117, 'Sigal', 'Tobias', 'sigal.tobias@momento.org', '+1-555-217-1017', '1996-03-15', 13, 4320.0, 'USD', 111, 3, 1),
  (118, 'Guy', 'Himuro', 'guy.himuro@momento.org', '+1-555-218-1018', '1996-09-17', 13, 3169.18, 'USD', 102, 3, 1),
  (119, 'Karen', 'Colmenares', 'karen.colmenares@momento.org', '+1-555-219-1019', '1997-01-20', 13, 4435.41, 'USD', 109, 3, 1),
  (120, 'Matthew', 'Weiss', 'matthew.weiss@momento.org', '+1-555-220-1020', '1997-08-06', 19, 7959.36, 'USD', 100, 5, 1),
  (121, 'Adam', 'Fripp', 'adam.fripp@momento.org', NULL, '1998-02-17', 19, 6676.34, 'USD', 114, 5, 1),
  (122, 'Payam', 'Kaufling', 'payam.kaufling@momento.org', '+1-555-222-1022', '1998-11-06', 19, 7902.1, 'USD', 105, 5, 1),
  (123, 'Shanta', 'Vollman', 'shanta.vollman@momento.org', '+1-555-223-1023', '1999-04-14', 19, 6609.23, 'USD', 121, 5, 1),
  (124, 'John', 'Russell', 'john.russell@momento.org', '+1-555-224-1024', '1999-10-11', 15, 16957.66, 'USD', 100, 8, 1),
  (125, 'Karen', 'Partners', 'karen.partners@momento.org', '+1-555-225-1025', '2000-06-13', 15, 16435.94, 'USD', 119, 8, 1),
  (126, 'Jonathon', 'Taylor', 'jonathon.taylor@momento.org', '+1-555-226-1026', '2000-12-17', 16, 7125.49, 'USD', 123, 8, 1),
  (127, 'Jack', 'Livingston', 'jack.livingston@momento.org', '+1-555-227-1027', '2001-05-09', 16, 7081.39, 'USD', 112, 8, 1),
  (128, 'Kimberly', 'Grant', 'kimberly.grant@momento.org', NULL, '2001-11-21', 16, 11790.28, 'USD', 120, 8, 1),
  (129, 'Jennifer', 'Whalen', 'jennifer.whalen@momento.org', '+1-555-229-1029', '2002-07-26', 3, 4653.76, 'USD', 100, 1, 1),
  (130, 'Elisabeth', 'Braddock', 'elisabeth.braddock@momento.org', '+1-555-230-1030', '2003-02-03', 10, 11971.26, 'USD', 124, 2, 1),
  (131, 'Pat', 'Ferreira', 'pat.ferreira@momento.org', '+1-555-231-1031', '2003-05-27', 11, 5226.53, 'USD', 101, 2, 1),
  (132, 'Susan', 'Mavris', 'susan.mavris@momento.org', '+1-555-232-1032', '2004-01-08', 8, 6035.47, 'USD', 104, 4, 1),
  (133, 'Hermann', 'Baer', 'hermann.baer@momento.org', '+1-555-233-1033', '2004-07-06', 12, 9854.88, 'USD', 120, 7, 1),
  (134, 'Shelley', 'Higgins', 'shelley.higgins@momento.org', '+1-555-234-1034', '2005-01-15', 2, 13265.79, 'USD', 125, 11, 1),
  (135, 'Susan', 'Storm', 'susan.storm@momento.org', NULL, '2005-09-20', 20, 23756.46, 'USD', 116, 12, 1),
  (136, 'Lucius', 'Fox', 'lucius.fox@momento.org', '+1-555-236-1036', '2006-01-26', 7, 15035.54, 'USD', 135, 10, 1),
  (137, 'Sabrina', 'Spellman', 'sabrina.spellman@momento.org', '+1-555-237-1037', '2006-09-27', 20, 19736.2, 'USD', 127, 13, 1),
  (138, 'Dick', 'Grayson', 'dick.grayson@momento.org', '+1-555-238-1038', '2007-04-14', 21, 8546.7, 'USD', 114, 6, 1),
  (139, 'Peter', 'Parker', 'peter.parker@momento.org', '+1-555-239-1039', '2007-08-28', 9, 7054.3, 'USD', 105, 6, 1),
  (140, 'Shuri', 'Udaku', 'shuri.udaku@momento.org', '+1-555-240-1040', '2008-02-26', 20, 32002.61, 'USD', 109, 13, 1),
  (141, 'Hermione', 'Granger', 'hermione.granger@momento.org', '+1-555-241-1041', '2008-11-19', 20, 17629.63, 'USD', 127, 13, 1),
  (142, 'Leia', 'Organa', 'leia.organa@momento.org', NULL, '2009-05-27', 12, 5012.11, 'USD', 124, 7, 1),
  (143, 'Spock', 'Sarek', 'spock.sarek@momento.org', '+1-555-243-1043', '2009-12-06', 20, 34770.49, 'USD', 133, 12, 1),
  (144, 'Samus', 'Aran', 'samus.aran@momento.org', '+1-555-244-1044', '2010-05-04', 21, 11690.93, 'USD', 100, 6, 1),
  (145, 'Miles', 'Morales', 'miles.morales@momento.org', '+1-555-245-1045', '2011-01-07', 20, 29124.8, 'USD', 143, 14, 1),
  (146, 'Kamala', 'Khan', 'kamala.khan@momento.org', '+1-555-246-1046', '2011-06-30', 27, 6803.69, 'USD', 141, 15, 1),
  (147, 'Carol', 'Danvers', 'carol.danvers@momento.org', '+1-555-247-1047', '2011-12-15', 25, 10232.06, 'USD', 127, 16, 1),
  (148, 'Natasha', 'Romanoff', 'natasha.romanoff@momento.org', '+1-555-248-1048', '2012-06-02', 24, 12551.12, 'USD', 146, 17, 1),
  (149, 'Clint', 'Barton', 'clint.barton@momento.org', NULL, '2012-12-25', 23, 11661.65, 'USD', 148, 18, 1),
  (150, 'Barbara', 'Gordon', 'barbara.gordon@momento.org', '+1-555-250-1050', '2013-06-25', 28, 9059.15, 'USD', 106, 19, 1),
  (151, 'Kara', 'Danvers', 'kara.danvers@momento.org', '+1-555-251-1051', '2014-03-03', 25, 12044.91, 'USD', 140, 20, 1),
  (152, 'Barry', 'Allen', 'barry.allen@momento.org', '+1-555-252-1052', '2014-08-27', 23, 9230.1, 'USD', 109, 21, 1),
  (153, 'Arthur', 'Curry', 'arthur.curry@momento.org', '+1-555-253-1053', '2015-02-19', 18, 4208.78, 'USD', 134, 22, 1),
  (154, 'Victor', 'Stone', 'victor.stone@momento.org', '+1-555-254-1054', '2015-09-20', 20, 33179.12, 'USD', 138, 14, 1),
  (155, 'Logan', 'Howlett', 'logan.howlett@momento.org', '+1-555-255-1055', '2016-03-05', 27, 5702.14, 'USD', 107, 15, 1),
  (156, 'Rogue', 'LeBeau', 'rogue.lebeau@momento.org', NULL, '2016-09-19', 25, 17673.6, 'USD', 153, 16, 1),
  (157, 'Ororo', 'Munroe', 'ororo.munroe@momento.org', '+1-555-257-1057', '2017-03-24', 24, 10472.69, 'USD', 115, 17, 1),
  (158, 'Jean', 'Grey', 'jean.grey@momento.org', '+1-555-258-1058', '2017-11-05', 23, 11494.56, 'USD', 105, 18, 1),
  (159, 'Scott', 'Summers', 'scott.summers@momento.org', '+1-555-259-1059', '2018-05-07', 28, 11433.38, 'USD', 148, 19, 1),
  (160, 'Cyborg', 'Stone', 'cyborg.stone@momento.org', '+1-555-260-1060', '2018-11-22', 25, 16578.59, 'USD', 108, 20, 1),
  (161, 'Nia', 'Nal', 'nia.nal@momento.org', '+1-555-261-1061', '2019-06-19', 23, 8334.39, 'USD', 135, 21, 1),
  (162, 'Mina', 'Harker', 'mina.harker@momento.org', '+1-555-262-1062', '2019-10-27', 18, 2865.65, 'USD', 155, 22, 1),
  (163, 'Ravi', 'Shah', 'ravi.shah@momento.org', NULL, '2020-07-02', 20, 23024.33, 'USD', 113, 14, 1),
  (164, 'Elena', 'Rossi', 'elena.rossi@momento.org', '+1-555-264-1064', '2021-01-03', 27, 6822.11, 'USD', 125, 15, 1),
  (165, 'Mateus', 'Silva', 'mateus.silva@momento.org', '+1-555-265-1065', '2021-06-15', 25, 13020.23, 'USD', 147, 16, 1),
  (166, 'Ana', 'Costa', 'ana.costa@momento.org', '+1-555-266-1066', '2022-01-11', 24, 16876.26, 'USD', 157, 17, 1),
  (167, 'Camila', 'Oliveira', 'camila.oliveira@momento.org', '+1-555-267-1067', '2022-06-12', 23, 6810.97, 'USD', 108, 18, 1),
  (168, 'Rafael', 'Santos', 'rafael.santos@momento.org', '+1-555-268-1068', '2023-01-19', 28, 5311.96, 'USD', 129, 19, 1),
  (169, 'Beatriz', 'Lima', 'beatriz.lima@momento.org', '+1-555-269-1069', '2023-09-01', 25, 11286.11, 'USD', 109, 20, 1),
  (170, 'Noah', 'Kim', 'noah.kim@momento.org', NULL, '1987-04-11', 23, 9378.39, 'USD', 129, 21, 1),
  (171, 'Yuki', 'Tanaka', 'yuki.tanaka@momento.org', '+1-555-271-1071', '1987-07-31', 18, 4594.63, 'USD', 142, 22, 1);

-- EDUCACIONAL

INSERT INTO funcionarios (funcionario_id, primeiro_nome, sobrenome, email, telefone, data_contratacao, cargo_id, salario, moeda_salario, gerente_id, departamento_id, status_funcionario_id) VALUES
-- Diretores (gerentes de topo, sem gerente)
(172, 'Helena', 'Parker', 'helena.parker@momento.edu', '+44-555-0101', '1995-03-15', 29, 18000.00, 'GBP', NULL, 28, 1),
(173, 'Minerva', 'McGivver', 'minerva.mcgivver@momento.edu', '+44-555-0102', '1998-07-22', 29, 15000.00, 'GBP', 172, 23, 1),
(174, 'Severo', 'Snape', 'severo.snape@momento.edu', '+44-555-0103', '1999-09-01', 32, 9500.00, 'GBP', 172, 23, 2),
(175, 'Rúbeo', 'Hagride', 'rubeo.Hagride@momento.edu', '+44-555-0104', '1993-11-10', 35, 4200.00, 'GBP', 172, 26, 1),
(176, 'Filius', 'Flitwick', 'filius.flitwick@momento.edu', '+44-555-0105', '1996-05-18', 30, 8500.00, 'GBP', 172, 24, 1),
(177, 'Pomona', 'Sprautii', 'pomona.sprautii@momento.edu', '+44-555-0106', '1997-04-03', 37, 6200.00, 'GBP', 172, 30, 1),
(178, 'Sybill', 'Trelawney', 'sybill.trelawney@momento.edu', '+44-555-0107', '2001-01-20', 31, 4800.00, 'GBP', 172, 29, 1),
-- Professores e staff
(179, 'Remo', 'Lupin', 'remo.lupin@momento.edu', '+44-555-0108', '2003-08-15', 31, 5500.00, 'GBP', 173, 25, 3),
(180, 'Ninfadora', 'Tonks', 'ninfadora.tonks@momento.edu', '+44-555-0109', '2008-02-11', 38, 7200.00, 'GBP', 173, 25, 1),
(181, 'Kingsley', 'Tremerraios', 'kingsley.tremerraios@momento.edu', '+44-555-0110', '2006-10-30', 38, 10500.00, 'GBP', 173, 25, 1),
(182, 'Horácio', 'Slughorn', 'horacio.slughorn@momento.edu', '+44-555-0111', '2009-06-12', 32, 8800.00, 'GBP', 174, 23, 1),
(183, 'Pomona', 'Rios', 'pomona.rios@momento.edu', '+44-555-0112', '2010-03-25', 33, 3600.00, 'GBP', 173, 26, 1),
(184, 'Argus', 'Filch', 'argus.filch@momento.edu', '+44-555-0113', '1990-09-01', 33, 3100.00, 'GBP', 172, 28, 1),
(185, 'Irma', 'Pince', 'irma.pince@momento.edu', '+44-555-0114', '1994-02-14', 34, 3700.00, 'GBP', 172, 27, 1),
(186, 'Poppy', 'Pomfrey', 'poppy.pomfrey@momento.edu', '+44-555-0115', '1992-07-07', 31, 5200.00, 'GBP', 172, 28, 1),
-- Paris
(187, 'Fleur', 'Dascores', 'fleur.dascores@momento.edu', '+33-555-0201', '2011-09-12', 30, 9200.00, 'EUR', NULL, 26, 1),
(188, 'Gabrielle', 'Dascores', 'gabrielle.dascores@momento.edu', '+33-555-0202', '2015-04-18', 40, 2400.00, 'EUR', 187, 26, 1),
(189, 'Olympe', 'Maxime', 'olympe.maxime@momento.edu', '+33-555-0203', '2005-11-01', 29, 14000.00, 'EUR', 187, 26, 1),
(190, 'Nicole', 'Rousseau', 'nicole.rousseau@momento.edu', '+33-555-0204', '2012-06-30', 34, 4100.00, 'EUR', 187, 27, 1),
(191, 'Atienne', 'Moreau', 'etienne.moreau@momento.edu', '+33-555-0205', '2013-08-22', 35, 3800.00, 'EUR', 187, 26, 2),
-- Lisboa
(192, 'Beatriz', 'Gonçalves', 'beatriz.goncalves@momento.edu', '+351-555-0301', '2014-01-15', 30, 7200.00, 'EUR', NULL, 27, 1),
(193, 'Tomas', 'Ferreira', 'tomas.ferreira@momento.edu', '+351-555-0302', '2016-03-09', 31, 4900.00, 'EUR', 192, 27, 1),
(194, 'Inuis', 'Salgado', 'ines.salgado@momento.edu', '+351-555-0303', '2017-10-02', 34, 3900.00, 'EUR', 192, 27, 1),
(195, 'Rui', 'Meireles', 'rui.meireles@momento.edu', '+351-555-0304', '2018-05-20', 37, 4300.00, 'EUR', 192, 30, 1),
(196, 'Carla', 'Nogueira', 'carla.nogueira@momento.edu', '+351-555-0305', '2019-09-11', 39, 2900.00, 'EUR', 192, 28, 3),
-- Rio de Janeiro (BRL)
(197, 'Paulo', 'Andrade', 'paulo.andrade@momento.edu', '+55-555-0401', '2013-02-28', 29, 45000.00, 'BRL', NULL, 28, 1),
(198, 'Marina', 'Costa', 'marina.costa@momento.edu', '+55-555-0402', '2015-07-14', 30, 22000.00, 'BRL', 197, 28, 1),
(199, 'Lucas', 'Pereira', 'lucas.pereira@momento.edu', '+55-555-0403', '2016-11-23', 32, 18000.00, 'BRL', 197, 23, 1),
(200, 'Fernanda', 'Lima', 'fernanda.lima@momento.edu', '+55-555-0404', '2017-04-17', 35, 9500.00, 'BRL', 197, 26, 1),
(201, 'Gustavo', 'Souza', 'gustavo.souza@momento.edu', '+55-555-0405', '2018-08-05', 33, 7800.00, 'BRL', 197, 28, 1),
(202, 'Ana', 'Martins', 'ana.martins@momento.edu', '+55-555-0406', '2019-12-01', 40, 5200.00, 'BRL', 198, 28, 1),
(203, 'Rodrigo', 'Alves', 'rodrigo.alves@momento.edu', '+55-555-0407', '2020-06-19', 31, 12000.00, 'BRL', 198, 24, 2),
-- Salem (USD)
(204, 'Elizabeth', 'Madpreta', 'elizabeth.madpreta@momento.edu', '+1-555-0501', '2010-10-31', 29, 17000.00, 'USD', NULL, 29, 1),
(205, 'Nathan', 'Hawthorne', 'nathan.hawthorne@momento.edu', '+1-555-0502', '2012-02-29', 36, 7800.00, 'USD', NULL, 29, 1),
(206, 'Samantha', 'Crowley', 'samantha.crowley@momento.edu', '+1-555-0503', '2014-09-15', 36, 6500.00, 'USD', 205, 29, 1),
(207, 'Daniel', 'Ravenwood', 'daniel.ravenwood@momento.edu', '+1-555-0504', '2015-03-07', 38, 9200.00, 'USD', 204, 25, 1),
(208, 'Olivia', 'Moon', 'olivia.moon@momento.edu', '+1-555-0505', '2016-07-21', 34, 4700.00, 'USD', 204, 27, 1),
(209, 'Ethan', 'Frost', 'ethan.frost@momento.edu', '+1-555-0506', '2017-11-30', 31, 5600.00, 'USD', 204, 25, 1),
(210, 'Grace', 'Willow', 'grace.willow@momento.edu', '+1-555-0507', '2018-04-12', 37, 6100.00, 'USD', 204, 30, 1),
(211, 'Jacob', 'Stone', 'jacob.stone@momento.edu', '+1-555-0508', '2019-01-25', 40, 2600.00, 'USD', 205, 29, 3),
-- Kyoto
(212, 'Haruki', 'Tanaka', 'haruki.tanaka@momento.edu', '+81-555-0601', '2011-05-05', 29, 16500.00, 'USD', NULL, 30, 1),
(213, 'Yuki', 'Sato', 'yuki.sato@momento.edu', '+81-555-0602', '2013-08-08', 37, 6800.00, 'USD', 212, 30, 1),
(214, 'Kenji', 'Nakamura', 'kenji.nakamura@momento.edu', '+81-555-0603', '2015-02-14', 31, 5100.00, 'USD', 212, 24, 1),
(215, 'Aiko', 'Yamamoto', 'aiko.yamamoto@momento.edu', '+81-555-0604', '2016-10-10', 35, 4400.00, 'USD', 212, 26, 1),
(216, 'Ryo', 'Kobayashi', 'ryo.kobayashi@momento.edu', '+81-555-0605', '2017-06-06', 33, 3900.00, 'USD', 212, 30, 2),
(217, 'Mei', 'Ito', 'mei.ito@momento.edu', '+81-555-0606', '2018-12-24', 34, 4200.00, 'USD', 212, 27, 1),
(218, 'Takumi', 'Watanabe', 'takumi.watanabe@momento.edu', '+81-555-0607', '2019-07-07', 39, 3100.00, 'USD', 212, 28, 1),
(219, 'Sakura', 'Mori', 'sakura.mori@momento.edu', '+81-555-0608', '2020-03-03', 40, 2400.00, 'USD', 213, 30, 1),
(220, 'Diego', 'Fernández', 'diego.fernandez@momento.edu', '+1-555-0509', '2021-01-18', 31, 5400.00, 'USD', 204, 25, 1),
(221, 'Larissa', 'Oliveira', 'larissa.oliveira@momento.edu', '+55-555-0408', '2022-02-22', 40, 4800.00, 'BRL', 198, 28, 1);

INSERT INTO dependentes (dependente_id, primeiro_nome, sobrenome, relacionamento, funcionario_id) VALUES
  (1, 'Alex', 'Prior', 'Filha(o)', 100),
  (2, 'Morgan', 'Prior', 'Cônjuge', 100),
  (3, 'Taylor', 'Kochhar', 'Filha(o)', 101),
  (4, 'Jordan', 'Kochhar', 'Pai/Mãe', 101),
  (5, 'Phomelo', 'T.Challa', 'Cônjuge', 102),
  (6, 'Ojira', 'T.Challa', 'Filha(o)', 102),
  (7, 'Jordan', 'Hunold', 'Pai/Mãe', 103),
  (8, 'Alex', 'Hunold', 'Filha(o)', 103),
  (9, 'Sam', 'Ernst', 'Filha(o)', 104),
  (10, 'Taylor', 'Ernst', 'Filha(o)', 104),
  (11, 'Alex', 'Austin', 'Filha(o)', 105),
  (12, 'Morgan', 'Austin', 'Cônjuge', 105),
  (13, 'Taylor', 'Stark', 'Filha(o)', 106),
  (14, 'Jordan', 'Stark', 'Pai/Mãe', 106),
  (15, 'Morgan', 'Lorentz', 'Cônjuge', 107),
  (16, 'Sam', 'Lorentz', 'Filha(o)', 107),
  (17, 'Jordan', 'Constantine', 'Pai/Mãe', 108),
  (18, 'Alex', 'Constantine', 'Filha(o)', 108),
  (19, 'Sam', 'Faviet', 'Filha(o)', 109),
  (20, 'Taylor', 'Faviet', 'Filha(o)', 109),
  (21, 'Alex', 'Chen', 'Filha(o)', 110),
  (22, 'Morgan', 'Chen', 'Cônjuge', 110),
  (23, 'Taylor', 'Sciarra', 'Filha(o)', 111),
  (24, 'Jordan', 'Sciarra', 'Pai/Mãe', 111),
  (25, 'Morgan', 'Urman', 'Cônjuge', 112),
  (26, 'Sam', 'Urman', 'Filha(o)', 112),
  (27, 'Jordan', 'Popp', 'Pai/Mãe', 113),
  (28, 'Alex', 'Popp', 'Filha(o)', 113),
  (29, 'Sam', 'Raphaely', 'Filha(o)', 114),
  (30, 'Taylor', 'Raphaely', 'Filha(o)', 114),
  (31, 'Alex', 'Osborn', 'Filha(o)', 115),
  (32, 'Morgan', 'Osborn', 'Cônjuge', 115),
  (33, 'Taylor', 'Baida', 'Filha(o)', 116),
  (34, 'Jordan', 'Baida', 'Pai/Mãe', 116),
  (35, 'Morgan', 'Tobias', 'Cônjuge', 117),
  (36, 'Sam', 'Tobias', 'Filha(o)', 117),
  (37, 'Jordan', 'Himuro', 'Pai/Mãe', 118),
  (38, 'Sam', 'Colmenares', 'Filha(o)', 119),
  (39, 'Alex', 'Weiss', 'Filha(o)', 120),
  (40, 'Taylor', 'Fripp', 'Filha(o)', 121),
  (41, 'Morgan', 'Kaufling', 'Cônjuge', 122),
  (42, 'Sam', 'Kaufling', 'Filha(o)', 122),
  (43, 'Jordan', 'Vollman', 'Pai/Mãe', 123),
  (44, 'Sam', 'Russell', 'Filha(o)', 124),
  (45, 'Alex', 'Partners', 'Filha(o)', 125),
  (46, 'Taylor', 'Taylor', 'Filha(o)', 126),
  (47, 'Morgan', 'Livingston', 'Cônjuge', 127),
  (48, 'Jordan', 'Grant', 'Pai/Mãe', 128),
  (49, 'Sam', 'Whalen', 'Filha(o)', 129),
  (50, 'Alex', 'Braddock', 'Filha(o)', 130),
  (51, 'Taylor', 'Ferreira', 'Filha(o)', 131),
  (52, 'Morgan', 'Mavris', 'Cônjuge', 132),
  (53, 'Jordan', 'Baer', 'Pai/Mãe', 133),
  (54, 'Alex', 'Baer', 'Filha(o)', 133),
  (55, 'Sam', 'Higgins', 'Filha(o)', 134),
  (56, 'Alex', 'Storm', 'Filha(o)', 135),
  (57, 'Taylor', 'Fox', 'Filha(o)', 136),
  (58, 'Morgan', 'Spellman', 'Cônjuge', 137),
  (59, 'Jordan', 'Grayson', 'Pai/Mãe', 138),
  (60, 'Sam', 'Parker', 'Filha(o)', 139),
  (61, 'Alex', 'Udaku', 'Filha(o)', 140),
  (62, 'Taylor', 'Granger', 'Filha(o)', 141),
  (63, 'Morgan', 'Organa', 'Cônjuge', 142),
  (64, 'Taylor', 'Aran', 'Filha(o)', 144),
  (65, 'Alex', 'Morales', 'Filha(o)', 145),
  (66, 'Jordan', 'Romanoff', 'Pai/Mãe', 148),
  (67, 'Taylor', 'Danvers', 'Filha(o)', 151),
  (68, 'Sam', 'Stone', 'Filha(o)', 154),
  (69, 'Morgan', 'Howlett', 'Cônjuge', 155),
  (70, 'Morgan', 'Munroe', 'Cônjuge', 157),
  (71, 'Alex', 'Stone', 'Filha(o)', 160),
  (72, 'Jordan', 'Shah', 'Pai/Mãe', 163),
  (73, 'Taylor', 'Costa', 'Filha(o)', 166),
  (74, 'Jordan', 'Costa', 'Pai/Mãe', 166),
  (75, 'Sam', 'Lima', 'Filha(o)', 169),
  (501, 'Fang', 'Hagride', 'Animal de estimação', 175),
  (502, 'Norberto', 'Hagride', 'Animal de estimação', 175),
  (503, 'Aragogue', 'Hagride', 'Animal de estimação', 175),
  (504, 'Bicuço', 'Hagride', 'Animal de estimação', 175),
  (505, 'Mafalda', 'McGivver', 'Sobrinha', 173),
  (506, 'Isabel', 'McGivver', 'Sobrinha', 173),
  (507, 'Dora', 'Tonks', 'Filha(o)', 180),
  (508, 'Remo', 'Tonks Jr.', 'Filha(o)', 180),
  (509, 'Victoire', 'Dascores', 'Filha(o)', 187),
  (510, 'Dominique', 'Dascores', 'Filha(o)', 187),
  (511, 'Louis', 'Dascores', 'Filha(o)', 187),
  (512, 'Amélie', 'Dascores', 'Sobrinha', 188),
  (513, 'Hugo', 'Rousseau', 'Filha(o)', 190),
  (514, 'Camille', 'Rousseau', 'Filha(o)', 190),
  (515, 'Théo', 'Moreau', 'Filha(o)', 191),
  (516, 'Léa', 'Moreau', 'Filha(o)', 191),
  (517, 'João', 'Gonçalves', 'Filha(o)', 192),
  (518, 'Maria', 'Gonçalves', 'Filha(o)', 192),
  (519, 'Pedro', 'Ferreira', 'Filha(o)', 193),
  (520, 'Sofia', 'Ferreira', 'Filha(o)', 193),
  (521, 'Rita', 'Salgado', 'Sobrinha', 194),
  (522, 'Nuno', 'Meireles', 'Filha(o)', 195),
  (523, 'Teresa', 'Nogueira', 'Mãe', 196),
  (524, 'Clara', 'Andrade', 'Filha(o)', 197),
  (525, 'Henrique', 'Andrade', 'Filha(o)', 197),
  (526, 'Júlia', 'Costa', 'Filha(o)', 198),
  (527, 'Rafael', 'Costa', 'Filha(o)', 198),
  (528, 'Bruno', 'Pereira', 'Filha(o)', 199),
  (529, 'Helena', 'Pereira', 'Filha(o)', 199),
  (530, 'Lorena', 'Lima', 'Filha(o)', 200),
  (531, 'Murilo', 'Lima', 'Filha(o)', 200),
  (532, 'Cláudio', 'Souza', 'Pai', 201),
  (533, 'Bianca', 'Martins', 'Filha(o)', 202),
  (534, 'Lucas', 'Martins', 'Filha(o)', 202),
  (535, 'Cecília', 'Alves', 'Filha(o)', 203),
  (536, 'Arthur', 'Alves', 'Filha(o)', 203),
  (537, 'Morgana', 'Madpreta', 'Filha(o)', 204),
  (538, 'Merlin', 'Madpreta', 'Filha(o)', 204),
  (539, 'Luna', 'Hawthorne', 'Filha(o)', 205),
  (540, 'Orion', 'Hawthorne', 'Filha(o)', 205),
  (541, 'Cassandra', 'Crowley', 'Filha(o)', 206),
  (542, 'Phoenix', 'Ravenwood', 'Filha(o)', 207),
  (543, 'Iris', 'Moon', 'Filha(o)', 208),
  (544, 'Hana', 'Tanaka', 'Filha(o)', 212),
  (545, 'Kaito', 'Tanaka', 'Filha(o)', 212);

INSERT INTO suprimentos (suprimento_id, referencia_compra, suprimento_nome, quantidade_estoque, custo_unitario, moeda, data_compra, escritorio_id) VALUES
  (1, 'PO-1400-01', 'Computadores', 8, 850.0, 'USD', '2024-01-10', 1400),
  (2, 'PO-1400-02', 'Monitores', 15, 220.0, 'USD', '2024-01-27', 1400),
  (3, 'PO-1400-03', 'Teclados', 31, 32.0, 'USD', '2024-02-13', 1400),
  (4, 'PO-1400-04', 'Headsets', 24, 75.0, 'USD', '2024-03-01', 1400),
  (5, 'PO-1400-05', 'Papel', 112, 6.0, 'USD', '2024-03-18', 1400),
  (6, 'PO-1400-06', 'Impressoras', 17, 240.0, 'USD', '2024-04-04', 1400),
  (7, 'PO-1400-07', 'Planners', 38, 8.0, 'USD', '2024-04-21', 1400),
  (8, 'PO-1500-01', 'Computadores', 15, 854.25, 'USD', '2024-02-18', 1500),
  (9, 'PO-1500-02', 'Monitores', 22, 224.25, 'USD', '2024-03-06', 1500),
  (10, 'PO-1500-03', 'Teclados', 38, 36.25, 'USD', '2024-03-23', 1500),
  (11, 'PO-1500-04', 'Headsets', 31, 79.25, 'USD', '2024-04-09', 1500),
  (12, 'PO-1500-05', 'Papel', 119, 10.25, 'USD', '2024-04-26', 1500),
  (13, 'PO-1500-06', 'Impressoras', 24, 244.25, 'USD', '2024-05-13', 1500),
  (14, 'PO-1500-07', 'Planners', 45, 12.25, 'USD', '2024-05-30', 1500),
  (15, 'PO-1700-01', 'Computadores', 22, 858.5, 'USD', '2024-03-28', 1700),
  (16, 'PO-1700-02', 'Monitores', 29, 228.5, 'USD', '2024-04-14', 1700),
  (17, 'PO-1700-03', 'Teclados', 45, 40.5, 'USD', '2024-05-01', 1700),
  (18, 'PO-1700-04', 'Headsets', 38, 83.5, 'USD', '2024-05-18', 1700),
  (19, 'PO-1700-05', 'Papel', 126, 14.5, 'USD', '2024-06-04', 1700),
  (20, 'PO-1700-06', 'Impressoras', 31, 248.5, 'USD', '2024-06-21', 1700),
  (21, 'PO-1700-07', 'Planners', 52, 16.5, 'USD', '2024-07-08', 1700),
  (22, 'PO-1800-01', 'Computadores', 29, 862.75, 'USD', '2024-05-06', 1800),
  (23, 'PO-1800-02', 'Monitores', 36, 232.75, 'USD', '2024-05-23', 1800),
  (24, 'PO-1800-03', 'Teclados', 52, 44.75, 'USD', '2024-06-09', 1800),
  (25, 'PO-1800-04', 'Headsets', 45, 87.75, 'USD', '2024-06-26', 1800),
  (26, 'PO-1800-05', 'Papel', 133, 18.75, 'USD', '2024-07-13', 1800),
  (27, 'PO-1800-06', 'Impressoras', 38, 252.75, 'USD', '2024-07-30', 1800),
  (28, 'PO-1800-07', 'Planners', 21, 20.75, 'USD', '2024-08-16', 1800),
  (29, 'PO-2400-01', 'Computadores', 36, 867.0, 'USD', '2024-06-14', 2400),
  (30, 'PO-2400-02', 'Monitores', 43, 237.0, 'USD', '2024-07-01', 2400),
  (31, 'PO-2400-03', 'Teclados', 59, 49.0, 'USD', '2024-07-18', 2400),
  (32, 'PO-2400-04', 'Headsets', 52, 92.0, 'USD', '2024-08-04', 2400),
  (33, 'PO-2400-05', 'Papel', 102, 23.0, 'USD', '2024-08-21', 2400),
  (34, 'PO-2400-06', 'Impressoras', 7, 257.0, 'USD', '2024-09-07', 2400),
  (35, 'PO-2400-07', 'Planners', 28, 25.0, 'USD', '2024-09-24', 2400),
  (36, 'PO-2500-01', 'Computadores', 43, 871.25, 'USD', '2024-07-23', 2500),
  (37, 'PO-2500-02', 'Monitores', 12, 241.25, 'USD', '2024-08-09', 2500),
  (38, 'PO-2500-03', 'Teclados', 28, 53.25, 'USD', '2024-08-26', 2500),
  (39, 'PO-2500-04', 'Headsets', 21, 96.25, 'USD', '2024-09-12', 2500),
  (40, 'PO-2500-05', 'Papel', 109, 27.25, 'USD', '2024-09-29', 2500),
  (41, 'PO-2500-06', 'Impressoras', 14, 261.25, 'USD', '2024-10-16', 2500),
  (42, 'PO-2500-07', 'Planners', 35, 29.25, 'USD', '2024-11-02', 2500),
  (43, 'PO-2700-01', 'Computadores', 12, 875.5, 'USD', '2024-08-31', 2700),
  (44, 'PO-2700-02', 'Monitores', 19, 245.5, 'USD', '2024-09-17', 2700),
  (45, 'PO-2700-03', 'Teclados', 35, 57.5, 'USD', '2024-10-04', 2700),
  (46, 'PO-2700-04', 'Headsets', 28, 100.5, 'USD', '2024-10-21', 2700),
  (47, 'PO-2700-05', 'Papel', 116, 31.5, 'USD', '2024-11-07', 2700),
  (48, 'PO-2700-06', 'Impressoras', 21, 265.5, 'USD', '2024-11-24', 2700),
  (49, 'PO-2700-07', 'Planners', 42, 33.5, 'USD', '2024-12-11', 2700),
  (50, 'PO-3900-01', 'Computadores', 19, 879.75, 'USD', '2024-10-09', 3900),
  (51, 'PO-3900-02', 'Monitores', 26, 249.75, 'USD', '2024-10-26', 3900),
  (52, 'PO-3900-03', 'Teclados', 42, 61.75, 'USD', '2024-11-12', 3900),
  (53, 'PO-3900-04', 'Headsets', 35, 104.75, 'USD', '2024-11-29', 3900),
  (54, 'PO-3900-05', 'Papel', 123, 35.75, 'USD', '2024-12-16', 3900),
  (55, 'PO-3900-06', 'Impressoras', 28, 269.75, 'USD', '2025-01-02', 3900),
  (56, 'PO-3900-07', 'Planners', 49, 37.75, 'USD', '2025-01-19', 3900),
  (57, 'PO-1900-01', 'Computadores', 26, 884.0, 'USD', '2024-11-17', 1900),
  (58, 'PO-1900-02', 'Monitores', 33, 254.0, 'USD', '2024-12-04', 1900),
  (59, 'PO-1900-03', 'Teclados', 49, 66.0, 'USD', '2024-12-21', 1900),
  (60, 'PO-1900-04', 'Headsets', 42, 109.0, 'USD', '2025-01-07', 1900),
  (61, 'PO-1900-05', 'Papel', 130, 40.0, 'USD', '2025-01-24', 1900),
  (62, 'PO-1900-06', 'Impressoras', 35, 274.0, 'USD', '2025-02-10', 1900),
  (63, 'PO-1900-07', 'Planners', 56, 42.0, 'USD', '2025-02-27', 1900),
  (64, 'PO-2600-01', 'Computadores', 33, 888.25, 'USD', '2024-12-26', 2600),
  (65, 'PO-2600-02', 'Monitores', 40, 258.25, 'USD', '2025-01-12', 2600),
  (66, 'PO-2600-03', 'Teclados', 56, 70.25, 'USD', '2025-01-29', 2600),
  (67, 'PO-2600-04', 'Headsets', 49, 113.25, 'USD', '2025-02-15', 2600),
  (68, 'PO-2600-05', 'Papel', 137, 44.25, 'USD', '2025-03-04', 2600),
  (69, 'PO-2600-06', 'Impressoras', 4, 278.25, 'USD', '2025-03-21', 2600),
  (70, 'PO-2600-07', 'Planners', 25, 46.25, 'USD', '2025-04-07', 2600),
  (71, 'PO-2800-01', 'Computadores', 40, 892.5, 'USD', '2025-02-03', 2800),
  (72, 'PO-2800-02', 'Monitores', 47, 262.5, 'USD', '2025-02-20', 2800),
  (73, 'PO-2800-03', 'Teclados', 25, 74.5, 'USD', '2025-03-09', 2800),
  (74, 'PO-2800-04', 'Headsets', 18, 117.5, 'USD', '2025-03-26', 2800),
  (75, 'PO-2800-05', 'Papel', 106, 48.5, 'USD', '2025-04-12', 2800),
  (76, 'PO-2800-06', 'Impressoras', 11, 282.5, 'USD', '2025-04-29', 2800),
  (77, 'PO-2800-07', 'Planners', 32, 50.5, 'USD', '2025-05-16', 2800),
  (78, 'PO-2900-01', 'Computadores', 9, 896.75, 'USD', '2025-03-14', 2900),
  (79, 'PO-2900-02', 'Monitores', 16, 266.75, 'USD', '2025-03-31', 2900),
  (80, 'PO-2900-03', 'Teclados', 32, 78.75, 'USD', '2025-04-17', 2900),
  (81, 'PO-2900-04', 'Headsets', 25, 121.75, 'USD', '2025-05-04', 2900),
  (82, 'PO-2900-05', 'Papel', 113, 52.75, 'USD', '2025-05-21', 2900),
  (83, 'PO-2900-06', 'Impressoras', 18, 286.75, 'USD', '2025-06-07', 2900),
  (84, 'PO-2900-07', 'Planners', 39, 54.75, 'USD', '2025-06-24', 2900),
  (85, 'PO-3000-01', 'Computadores', 16, 901.0, 'USD', '2025-04-22', 3000),
  (86, 'PO-3000-02', 'Monitores', 23, 271.0, 'USD', '2025-05-09', 3000),
  (87, 'PO-3000-03', 'Teclados', 39, 83.0, 'USD', '2025-05-26', 3000),
  (88, 'PO-3000-04', 'Headsets', 32, 126.0, 'USD', '2025-06-12', 3000),
  (89, 'PO-3000-05', 'Papel', 120, 57.0, 'USD', '2025-06-29', 3000),
  (90, 'PO-3000-06', 'Impressoras', 25, 291.0, 'USD', '2025-07-16', 3000),
  (91, 'PO-3000-07', 'Planners', 46, 59.0, 'USD', '2025-08-02', 3000),
  (92, 'PO-3100-01', 'Computadores', 23, 905.25, 'USD', '2025-05-31', 3100),
  (93, 'PO-3100-02', 'Monitores', 30, 275.25, 'USD', '2025-06-17', 3100),
  (94, 'PO-3100-03', 'Teclados', 46, 87.25, 'USD', '2025-07-04', 3100),
  (95, 'PO-3100-04', 'Headsets', 39, 130.25, 'USD', '2025-07-21', 3100),
  (96, 'PO-3100-05', 'Papel', 127, 61.25, 'USD', '2025-08-07', 3100),
  (97, 'PO-3100-06', 'Impressoras', 32, 295.25, 'USD', '2025-08-24', 3100),
  (98, 'PO-3100-07', 'Planners', 53, 63.25, 'USD', '2025-09-10', 3100),
  (99, 'PO-3200-01', 'Computadores', 30, 909.5, 'USD', '2025-07-09', 3200),
  (100, 'PO-3200-02', 'Monitores', 37, 279.5, 'USD', '2025-07-26', 3200),
  (101, 'PO-3200-03', 'Teclados', 53, 91.5, 'USD', '2025-08-12', 3200),
  (102, 'PO-3200-04', 'Headsets', 46, 134.5, 'USD', '2025-08-29', 3200),
  (103, 'PO-3200-05', 'Papel', 134, 65.5, 'USD', '2025-09-15', 3200),
  (104, 'PO-3200-06', 'Impressoras', 39, 299.5, 'USD', '2025-10-02', 3200),
  (105, 'PO-3200-07', 'Planners', 22, 67.5, 'USD', '2025-10-19', 3200);

INSERT INTO categorias_produto (categoria_id, categoria_nome) VALUES
  (1, 'Uniformes'),
  (2, 'Acessórios'),
  (3, 'Equipamentos'),
  (4, 'Colecionáveis'),
  (5, 'Tecnologia'),
  (6, 'Armas cenográficas'),
  (7, 'Brinquedos'),
  (8, 'Artefatos'),
  (9, 'Simbiontes');

INSERT INTO produtos (produto_id, sku, produto_nome, categoria_id, preco_catalogo, moeda, ativo) VALUES
  (1, 'POP-001', 'Uniforme do Superman', 1, 300.13, 'USD', 1),
  (2, 'BAT-001', 'Batarang de treino', 2, 239.29, 'USD', 1),
  (3, 'WEB-001', 'Lança-Teias', 3, 237.19, 'USD', 1),
  (4, 'ANT-001', 'Capacete do Homem-Formiga', 2, 289.29, 'USD', 1),
  (5, 'COS-001', 'Nulificador Total', 8, 750.19, 'USD', 1),
  (6, 'WW-001', 'Laço da Verdade', 6, 325.13, 'USD', 1),
  (7, 'IM-005', 'Capacete Iron Man Mark 5', 2, 322.29, 'USD', 1),
  (8, 'SW-001', 'Sabre de luz de Mace Windu', 6, 990.29, 'USD', 1),
  (9, 'X-001', 'Sentinela em miniatura', 4, 150.13, 'USD', 1),
  (10, 'X-002', 'Uniforme de moléculas instáveis', 1, 158.29, 'USD', 1),
  (11, 'WW-002', 'Laço da Honestidade', 6, 649.29, 'USD', 1),
  (12, 'BAT-002', 'Batarangs oficiais', 6, 900.29, 'USD', 1),
  (13, 'ROB-001', 'Símbolo do Robin', 2, 32.29, 'USD', 1),
  (14, 'PKM-001', 'Pokébola clássica', 7, 35.0, 'USD', 1),
  (15, 'PKM-002', 'Pokédex portátil', 5, 200.0, 'USD', 1),
  (16, 'SW-002', 'Capacete Darth Vader', 2, 4500.0, 'USD', 1),
  (17, 'MAR-001', 'Escudo do Capitão América', 3, 4500.0, 'USD', 1),
  (18, 'LOTR-001', 'Anel do Poder (réplica)', 8, 999.99, 'USD', 1),
  (19, 'DBZ-001', 'Scouter', 5, 500.0, 'USD', 1),
  (20, 'ZEL-001', 'Master Sword (réplica)', 6, 1800.0, 'USD', 1),
  (21, 'FF-001', 'Buster Sword (réplica)', 6, 1299.0, 'USD', 1),
  (22, 'HP-001', 'Varinha de Harry Potter', 8, 250.0, 'USD', 1),
  (23, 'SW-003', 'Blaster Imperial', 6, 750.0, 'USD', 1),
  (24, 'MAR-002', 'Tesseract decorativo', 8, 7000.0, 'USD', 1),
  (25, 'DC-003', 'Caixa Materna cenográfica', 5, 1200.0, 'USD', 1),
  (26, 'BEN-001', 'Omnitrix', 5, 300.0, 'USD', 1),
  (27, 'GOW-001', 'Lâminas do Caos cenográficas', 6, 3000.0, 'USD', 1),
  (28, 'DBZ-002', 'Cápsula Hoi-Poi', 5, 60.0, 'USD', 1),
  (29, 'SW-004', 'Blaster de Han Solo', 6, 400.0, 'USD', 1),
  (30, 'MAR-003', 'Manopla do Infinito', 8, 5000.0, 'USD', 1),
  (31, 'SW-005', 'Sabre de luz vermelho', 6, 850.0, 'USD', 1),
  (32, 'DC-004', 'Capa do Batman', 1, 180.0, 'USD', 1),
  (33, 'MAR-004', 'Reator Arc decorativo', 5, 650.0, 'USD', 1),
  (34, 'HP-002', 'Chapéu Seletor', 8, 400.0, 'USD', 1),
  (35, 'ZEL-002', 'Escudo Hyliano', 3, 1250.0, 'USD', 1),
  (36, 'PKM-003', 'Boné do treinador', 2, 50.0, 'USD', 1);

INSERT INTO vendas (venda_id, referencia_origem, data_venda, funcionario_id, canal_venda_id, status_venda_id) VALUES
  (7001, 'ERP-7001', '2023-01-03', 124, 1, 3),
  (7002, 'ERP-7002', '2023-01-22', 125, 2, 1),
  (7003, 'ERP-7003', '2023-02-10', 126, 3, 1),
  (7004, 'ERP-7004', '2023-03-01', 127, 4, 1),
  (7005, 'ERP-7005', '2023-03-20', 128, 5, 1),
  (7006, 'ERP-7006', '2023-04-08', 124, 1, 1),
  (7007, 'ERP-7007', '2023-04-27', 125, 2, 1),
  (7008, 'ERP-7008', '2023-05-16', 126, 3, 1),
  (7009, 'ERP-7009', '2023-06-04', 127, 4, 1),
  (7010, 'ERP-7010', '2023-06-23', 128, 5, 1),
  (7011, 'ERP-7011', '2023-07-12', 124, 1, 1),
  (7012, 'ERP-7012', '2023-07-31', 125, 2, 1),
  (7013, 'ERP-7013', '2023-08-19', 126, 3, 1),
  (7014, 'ERP-7014', '2023-09-07', 127, 4, 2),
  (7015, 'ERP-7015', '2023-09-26', 128, 5, 1),
  (7016, 'ERP-7016', '2023-10-15', 124, 1, 1),
  (7017, 'ERP-7017', '2023-11-03', 125, 2, 1),
  (7018, 'ERP-7018', '2023-11-22', 126, 3, 3),
  (7019, 'ERP-7019', '2023-12-11', 127, 4, 1),
  (7020, 'ERP-7020', '2023-12-30', 128, 5, 1),
  (7021, 'ERP-7021', '2024-01-18', 124, 1, 1),
  (7022, 'ERP-7022', '2024-02-06', 125, 2, 1),
  (7023, 'ERP-7023', '2024-02-25', 126, 3, 1),
  (7024, 'ERP-7024', '2024-03-15', 127, 4, 1),
  (7025, 'ERP-7025', '2024-04-03', 128, 5, 1),
  (7026, 'ERP-7026', '2024-04-22', 124, 1, 1),
  (7027, 'ERP-7027', '2024-05-11', 125, 2, 2),
  (7028, 'ERP-7028', '2024-05-30', 126, 3, 1),
  (7029, 'ERP-7029', '2024-06-18', 127, 4, 1),
  (7030, 'ERP-7030', '2024-07-07', 128, 5, 1),
  (7031, 'ERP-7031', '2024-07-26', 124, 1, 1),
  (7032, 'ERP-7032', '2024-08-14', 125, 2, 1),
  (7033, 'ERP-7033', '2024-09-02', 126, 3, 1),
  (7034, 'ERP-7034', '2024-09-21', 127, 4, 1),
  (7035, 'ERP-7035', '2024-10-10', 128, 5, 3),
  (7036, 'ERP-7036', '2024-10-29', 124, 1, 1),
  (7037, 'ERP-7037', '2024-11-17', 125, 2, 1),
  (7038, 'ERP-7038', '2024-12-06', 126, 3, 1),
  (7039, 'ERP-7039', '2024-12-25', 127, 4, 1),
  (7040, 'ERP-7040', '2025-01-13', 128, 5, 2),
  (7041, 'ERP-7041', '2025-02-01', 124, 1, 1),
  (7042, 'ERP-7042', '2025-02-20', 125, 2, 1),
  (7043, 'ERP-7043', '2025-03-11', 126, 3, 1),
  (7044, 'ERP-7044', '2025-03-30', 127, 4, 1),
  (7045, 'ERP-7045', '2025-04-18', 128, 5, 1),
  (7046, 'ERP-7046', '2025-05-07', 124, 1, 1),
  (7047, 'ERP-7047', '2025-05-26', 125, 2, 1),
  (7048, 'ERP-7048', '2025-06-14', 126, 3, 1),
  (7049, 'ERP-7049', '2025-07-03', 127, 4, 1),
  (7050, 'ERP-7050', '2025-07-22', 128, 5, 1),
  (7051, 'ERP-7051', '2025-08-10', 124, 1, 1),
  (7052, 'ERP-7052', '2023-01-12', 125, 2, 3),
  (7053, 'ERP-7053', '2023-01-31', 126, 3, 2),
  (7054, 'ERP-7054', '2023-02-19', 127, 4, 1);

INSERT INTO itens_venda (item_venda_id, venda_id, numero_item, produto_id, quantidade, preco_unitario, moeda, source_row_id) VALUES
  (1, 7001, 1, 6, 3, 271.67, 'USD', NULL),
  (2, 7001, 2, 11, 5, 566.42, 'USD', NULL),
  (3, 7001, 3, 16, 7, 4352.29, 'USD', NULL),
  (4, 7002, 1, 9, 4, 130.18, 'USD', NULL),
  (5, 7003, 1, 12, 5, 764.44, 'USD', NULL),
  (6, 7004, 1, 15, 6, 205.16, 'USD', NULL),
  (7, 7004, 2, 20, 8, 1702.13, 'USD', NULL),
  (8, 7005, 1, 18, 7, 923.98, 'USD', NULL),
  (9, 7006, 1, 21, 8, 1289.41, 'USD', NULL),
  (10, 7007, 1, 24, 9, 6983.55, 'USD', NULL),
  (11, 7007, 2, 29, 11, 344.76, 'USD', NULL),
  (12, 7008, 1, 27, 10, 2523.97, 'USD', NULL),
  (13, 7008, 2, 32, 12, 164.67, 'USD', NULL),
  (14, 7009, 1, 30, 11, 4565.94, 'USD', NULL),
  (15, 7010, 1, 33, 12, 599.78, 'USD', NULL),
  (16, 7010, 2, 2, 2, 234.60, 'USD', NULL),
  (17, 7011, 1, 36, 1, 48.41, 'USD', NULL),
  (18, 7012, 1, 3, 2, 245.85, 'USD', NULL),
  (19, 7013, 1, 6, 3, 273.65, 'USD', NULL),
  (20, 7013, 2, 11, 5, 589.93, 'USD', NULL),
  (21, 7014, 1, 9, 4, 134.31, 'USD', NULL),
  (22, 7015, 1, 12, 5, 908.90, 'USD', NULL),
  (23, 7015, 2, 17, 7, 3936.17, 'USD', NULL),
  (24, 7016, 1, 15, 6, 172.37, 'USD', NULL),
  (25, 7016, 2, 20, 8, 1653.65, 'USD', NULL),
  (26, 7017, 1, 18, 7, 912.80, 'USD', NULL),
  (27, 7018, 1, 21, 8, 1144.78, 'USD', NULL),
  (28, 7019, 1, 24, 9, 6124.70, 'USD', NULL),
  (29, 7019, 2, 29, 11, 409.25, 'USD', NULL),
  (30, 7020, 1, 27, 10, 2752.47, 'USD', NULL),
  (31, 7021, 1, 30, 11, 5047.48, 'USD', NULL),
  (32, 7022, 1, 33, 12, 611.70, 'USD', NULL),
  (33, 7022, 2, 2, 2, 198.88, 'USD', NULL),
  (34, 7022, 3, 7, 4, 335.13, 'USD', NULL),
  (35, 7023, 1, 36, 1, 50.20, 'USD', NULL),
  (36, 7024, 1, 3, 2, 245.06, 'USD', NULL),
  (37, 7025, 1, 6, 3, 332.87, 'USD', NULL),
  (38, 7025, 2, 11, 5, 653.65, 'USD', NULL),
  (39, 7026, 1, 9, 4, 128.60, 'USD', NULL),
  (40, 7027, 1, 12, 5, 834.43, 'USD', NULL),
  (41, 7028, 1, 15, 6, 173.40, 'USD', NULL),
  (42, 7028, 2, 20, 8, 1634.81, 'USD', NULL),
  (43, 7029, 1, 18, 7, 832.89, 'USD', NULL),
  (44, 7029, 2, 23, 9, 677.53, 'USD', NULL),
  (45, 7030, 1, 21, 8, 1346.76, 'USD', NULL),
  (46, 7031, 1, 24, 9, 6148.41, 'USD', NULL),
  (47, 7031, 2, 29, 11, 397.00, 'USD', NULL),
  (48, 7032, 1, 27, 10, 2760.31, 'USD', NULL),
  (49, 7033, 1, 30, 11, 4565.31, 'USD', NULL),
  (50, 7034, 1, 33, 12, 669.90, 'USD', NULL),
  (51, 7034, 2, 2, 2, 248.62, 'USD', NULL),
  (52, 7035, 1, 36, 1, 47.11, 'USD', NULL),
  (53, 7036, 1, 3, 2, 231.98, 'USD', NULL),
  (54, 7036, 2, 8, 4, 845.76, 'USD', NULL),
  (55, 7037, 1, 6, 3, 287.83, 'USD', NULL),
  (56, 7037, 2, 11, 5, 670.79, 'USD', NULL),
  (57, 7038, 1, 9, 4, 142.24, 'USD', NULL),
  (58, 7039, 1, 12, 5, 845.63, 'USD', NULL),
  (59, 7040, 1, 15, 6, 196.91, 'USD', NULL),
  (60, 7040, 2, 20, 8, 1498.64, 'USD', NULL),
  (61, 7041, 1, 18, 7, 948.51, 'USD', NULL),
  (62, 7042, 1, 21, 8, 1208.88, 'USD', NULL),
  (63, 7043, 1, 24, 9, 7053.19, 'USD', NULL),
  (64, 7043, 2, 29, 11, 341.85, 'USD', NULL),
  (65, 7043, 3, 34, 1, 412.55, 'USD', NULL),
  (66, 7044, 1, 27, 10, 2512.87, 'USD', NULL),
  (67, 7045, 1, 30, 11, 4304.41, 'USD', NULL),
  (68, 7046, 1, 33, 12, 618.09, 'USD', NULL),
  (69, 7046, 2, 2, 2, 231.76, 'USD', NULL),
  (70, 7047, 1, 36, 1, 43.59, 'USD', NULL),
  (71, 7048, 1, 3, 2, 200.75, 'USD', NULL),
  (72, 7049, 1, 6, 3, 330.29, 'USD', NULL),
  (73, 7049, 2, 11, 5, 567.59, 'USD', NULL),
  (74, 7050, 1, 9, 4, 142.74, 'USD', NULL),
  (75, 7050, 2, 14, 6, 33.47, 'USD', NULL),
  (76, 7051, 1, 12, 5, 821.27, 'USD', NULL),
  (77, 7052, 1, 15, 6, 189.68, 'USD', NULL),
  (78, 7052, 2, 20, 8, 1683.02, 'USD', NULL),
  (79, 7053, 1, 18, 7, 1025.63, 'USD', NULL),
  (80, 7054, 1, 21, 8, 1123.55, 'USD', NULL);

INSERT INTO audit_log (log_id, log_acao, log_ts, modulo_auditoria_id, status_auditoria_id, log_origem, log_detalhes, funcionario_id) VALUES
  (1, 'Consultou catálogo', '2024-01-04 09:13:00', 1, 2, 'Terminal-02', 'Evento de demonstração 001', 107),
  (2, 'Exportou relatório', '2024-01-07 10:26:00', 2, 2, 'Terminal-03', 'Evento de demonstração 002', 114),
  (3, 'Atualizou inventário', '2024-01-10 11:39:00', 3, 1, 'Terminal-04', 'Evento de demonstração 003', 121),
  (4, 'Solicitou compra', '2024-01-13 12:52:00', 4, 3, 'Terminal-05', 'Evento de demonstração 004', 128),
  (5, 'Revisou permissões', '2024-01-16 13:05:00', 5, 4, 'Terminal-06', 'Evento de demonstração 005', 135),
  (6, 'Logout', '2024-01-19 14:18:00', 6, 2, 'Terminal-07', 'Evento de demonstração 006', 142),
  (7, 'Falha de autenticação', '2024-01-22 15:31:00', 1, 2, 'Terminal-08', 'Evento de demonstração 007', 149),
  (8, 'Login', '2024-01-25 16:44:00', 2, 2, 'Terminal-09', 'Evento de demonstração 008', 156),
  (9, 'Consultou catálogo', '2024-01-28 17:57:00', 3, 1, 'Terminal-10', 'Evento de demonstração 009', 163),
  (10, 'Exportou relatório', '2024-01-31 08:10:00', 4, 3, 'Terminal-11', 'Evento de demonstração 010', 170),
  (11, 'Atualizou inventário', '2024-02-03 09:23:00', 5, 4, 'Terminal-12', 'Evento de demonstração 011', 105),
  (12, 'Solicitou compra', '2024-02-06 10:36:00', 6, 2, 'Terminal-01', 'Evento de demonstração 012', 112),
  (13, 'Revisou permissões', '2024-02-09 11:49:00', 1, 2, 'Terminal-02', 'Evento de demonstração 013', 119),
  (14, 'Logout', '2024-02-12 12:02:00', 2, 2, 'Terminal-03', 'Evento de demonstração 014', 126),
  (15, 'Falha de autenticação', '2024-02-15 13:15:00', 3, 1, 'Terminal-04', 'Evento de demonstração 015', 133),
  (16, 'Login', '2024-02-18 14:28:00', 4, 3, 'Terminal-05', 'Evento de demonstração 016', 140),
  (17, 'Consultou catálogo', '2024-02-21 15:41:00', 5, 4, 'Terminal-06', 'Evento de demonstração 017', 147),
  (18, 'Exportou relatório', '2024-02-24 16:54:00', 6, 2, 'Terminal-07', 'Evento de demonstração 018', 154),
  (19, 'Atualizou inventário', '2024-02-27 17:07:00', 1, 2, 'Terminal-08', 'Evento de demonstração 019', 161),
  (20, 'Solicitou compra', '2024-03-01 08:20:00', 2, 2, 'Terminal-09', 'Evento de demonstração 020', 168),
  (21, 'Revisou permissões', '2024-03-04 09:33:00', 3, 1, 'Terminal-10', 'Evento de demonstração 021', 103),
  (22, 'Logout', '2024-03-07 10:46:00', 4, 3, 'Terminal-11', 'Evento de demonstração 022', 110),
  (23, 'Falha de autenticação', '2024-03-10 11:59:00', 5, 4, 'Terminal-12', 'Evento de demonstração 023', 117),
  (24, 'Login', '2024-03-13 12:12:00', 6, 2, 'Terminal-01', 'Evento de demonstração 024', 124),
  (25, 'Consultou catálogo', '2024-03-16 13:25:00', 1, 2, 'Terminal-02', 'Evento de demonstração 025', 131),
  (26, 'Exportou relatório', '2024-03-19 14:38:00', 2, 2, 'Terminal-03', 'Evento de demonstração 026', 138),
  (27, 'Atualizou inventário', '2024-03-22 15:51:00', 3, 1, 'Terminal-04', 'Evento de demonstração 027', 145),
  (28, 'Solicitou compra', '2024-03-25 16:04:00', 4, 3, 'Terminal-05', 'Evento de demonstração 028', 152),
  (29, 'Revisou permissões', '2024-03-28 17:17:00', 5, 4, 'Terminal-06', 'Evento de demonstração 029', 159),
  (30, 'Logout', '2024-03-31 08:30:00', 6, 2, 'Terminal-07', 'Evento de demonstração 030', 166),
  (31, 'Falha de autenticação', '2024-04-03 09:43:00', 1, 2, 'Terminal-08', 'Evento de demonstração 031', 101),
  (32, 'Login', '2024-04-06 10:56:00', 2, 2, 'Terminal-09', 'Evento de demonstração 032', 108),
  (33, 'Consultou catálogo', '2024-04-09 11:09:00', 3, 1, 'Terminal-10', 'Evento de demonstração 033', 115),
  (34, 'Exportou relatório', '2024-04-12 12:22:00', 4, 3, 'Terminal-11', 'Evento de demonstração 034', 122),
  (35, 'Atualizou inventário', '2024-04-15 13:35:00', 5, 4, 'Terminal-12', 'Evento de demonstração 035', 129),
  (36, 'Solicitou compra', '2024-04-18 14:48:00', 6, 2, 'Terminal-01', 'Evento de demonstração 036', 136),
  (37, 'Revisou permissões', '2024-04-21 15:01:00', 1, 2, 'Terminal-02', 'Evento de demonstração 037', 143),
  (38, 'Logout', '2024-04-24 16:14:00', 2, 2, 'Terminal-03', 'Evento de demonstração 038', 150),
  (39, 'Falha de autenticação', '2024-04-27 17:27:00', 3, 1, 'Terminal-04', 'Evento de demonstração 039', 157),
  (40, 'Login', '2024-04-30 08:40:00', 4, 3, 'Terminal-05', 'Evento de demonstração 040', 164),
  (41, 'Consultou catálogo', '2024-05-03 09:53:00', 5, 4, 'Terminal-06', 'Evento de demonstração 041', 171),
  (42, 'Exportou relatório', '2024-05-06 10:06:00', 6, 2, 'Terminal-07', 'Evento de demonstração 042', 106),
  (43, 'Atualizou inventário', '2024-05-09 11:19:00', 1, 2, 'Terminal-08', 'Evento de demonstração 043', 113),
  (44, 'Solicitou compra', '2024-05-12 12:32:00', 2, 2, 'Terminal-09', 'Evento de demonstração 044', 120),
  (45, 'Revisou permissões', '2024-05-15 13:45:00', 3, 1, 'Terminal-10', 'Evento de demonstração 045', 127),
  (46, 'Logout', '2024-05-18 14:58:00', 4, 3, 'Terminal-11', 'Evento de demonstração 046', 134),
  (47, 'Falha de autenticação', '2024-05-21 15:11:00', 5, 4, 'Terminal-12', 'Evento de demonstração 047', 141),
  (48, 'Login', '2024-05-24 16:24:00', 6, 2, 'Terminal-01', 'Evento de demonstração 048', 148),
  (49, 'Consultou catálogo', '2024-05-27 17:37:00', 1, 2, 'Terminal-02', 'Evento de demonstração 049', 155),
  (50, 'Exportou relatório', '2024-05-30 08:50:00', 2, 2, 'Terminal-03', 'Evento de demonstração 050', 162),
  (51, 'Atualizou inventário', '2024-06-02 09:03:00', 3, 1, 'Terminal-04', 'Evento de demonstração 051', 169),
  (52, 'Solicitou compra', '2024-06-05 10:16:00', 4, 3, 'Terminal-05', 'Evento de demonstração 052', 104),
  (53, 'Revisou permissões', '2024-06-08 11:29:00', 5, 4, 'Terminal-06', 'Evento de demonstração 053', 111),
  (54, 'Logout', '2024-06-11 12:42:00', 6, 2, 'Terminal-07', 'Evento de demonstração 054', 118),
  (55, 'Falha de autenticação', '2024-06-14 13:55:00', 1, 2, 'Terminal-08', 'Evento de demonstração 055', 125),
  (56, 'Login', '2024-06-17 14:08:00', 2, 2, 'Terminal-09', 'Evento de demonstração 056', 132),
  (57, 'Consultou catálogo', '2024-06-20 15:21:00', 3, 1, 'Terminal-10', 'Evento de demonstração 057', 139),
  (58, 'Exportou relatório', '2024-06-23 16:34:00', 4, 3, 'Terminal-11', 'Evento de demonstração 058', 146),
  (59, 'Atualizou inventário', '2024-06-26 17:47:00', 5, 4, 'Terminal-12', 'Evento de demonstração 059', 153),
  (60, 'Solicitou compra', '2024-06-29 08:00:00', 6, 2, 'Terminal-01', 'Evento de demonstração 060', 160),
  (61, 'Revisou permissões', '2024-07-02 09:13:00', 1, 2, 'Terminal-02', 'Evento de demonstração 061', 167),
  (62, 'Logout', '2024-07-05 10:26:00', 2, 2, 'Terminal-03', 'Evento de demonstração 062', 102),
  (63, 'Falha de autenticação', '2024-07-08 11:39:00', 3, 1, 'Terminal-04', 'Evento de demonstração 063', 109),
  (64, 'Login', '2024-07-11 12:52:00', 4, 3, 'Terminal-05', 'Evento de demonstração 064', 116),
  (65, 'Consultou catálogo', '2024-07-14 13:05:00', 5, 4, 'Terminal-06', 'Evento de demonstração 065', 123),
  (66, 'Exportou relatório', '2024-07-17 14:18:00', 6, 2, 'Terminal-07', 'Evento de demonstração 066', 130),
  (67, 'Atualizou inventário', '2024-07-20 15:31:00', 1, 2, 'Terminal-08', 'Evento de demonstração 067', 137),
  (68, 'Solicitou compra', '2024-07-23 16:44:00', 2, 2, 'Terminal-09', 'Evento de demonstração 068', 144),
  (69, 'Revisou permissões', '2024-07-26 17:57:00', 3, 1, 'Terminal-10', 'Evento de demonstração 069', 151),
  (70, 'Logout', '2024-07-29 08:10:00', 4, 3, 'Terminal-11', 'Evento de demonstração 070', 158),
  (71, 'Falha de autenticação', '2024-08-01 09:23:00', 5, 4, 'Terminal-12', 'Evento de demonstração 071', 165),
  (72, 'Login', '2024-08-04 10:36:00', 6, 2, 'Terminal-01', 'Evento de demonstração 072', 100),
  (73, 'Consultou catálogo', '2024-08-07 11:49:00', 1, 2, 'Terminal-02', 'Evento de demonstração 073', 107),
  (74, 'Exportou relatório', '2024-08-10 12:02:00', 2, 2, 'Terminal-03', 'Evento de demonstração 074', 114),
  (75, 'Atualizou inventário', '2024-08-13 13:15:00', 3, 1, 'Terminal-04', 'Evento de demonstração 075', 121),
  (76, 'Solicitou compra', '2024-08-16 14:28:00', 4, 3, 'Terminal-05', 'Evento de demonstração 076', 128),
  (77, 'Revisou permissões', '2024-08-19 15:41:00', 5, 4, 'Terminal-06', 'Evento de demonstração 077', 135),
  (78, 'Logout', '2024-08-22 16:54:00', 6, 2, 'Terminal-07', 'Evento de demonstração 078', 142),
  (79, 'Falha de autenticação', '2024-08-25 17:07:00', 1, 2, 'Terminal-08', 'Evento de demonstração 079', 149),
  (80, 'Login', '2024-08-28 08:20:00', 2, 2, 'Terminal-09', 'Evento de demonstração 080', 156);

-- Dados demonstrativos do modelo ampliado. Staging e rejeições continuam vazios:
-- dependem de uma carga externa e da validação dela.
INSERT INTO clientes (cliente_id, nome, email, telefone, data_cadastro, consentimento_marketing, status_cliente_id) VALUES
  (1, 'Alex Morgan', 'alex.morgan@example.com', '+1-555-9001', '2023-01-20', 1, 1),
  (2, 'Mariana Souza', 'mariana.souza@example.com', '+55-11-5555-9002', '2023-06-15', 1, 1),
  (3, 'Theo Martin', 'theo.martin@example.com', '+33-1-5555-9003', '2024-02-10', 0, 1),
  (4, 'Luna Kim', 'luna.kim@example.com', '+81-3-5555-9004', '2024-09-01', 1, 1);
  
INSERT INTO enderecos_cliente (endereco_cliente_id, cliente_id, tipo, endereco, cidade, estado_provincia, cep, pais_id, principal) VALUES
  (1, 1, 'ENTREGA', '10 Market Street', 'Seattle', 'Washington', '98101', 'US', 1),
  (2, 2, 'ENTREGA', 'Rua das Artes, 55', 'São Paulo', 'SP', '01310-100', 'BR', 1),
  (3, 3, 'ENTREGA', '12 Rue des Jeux', 'Paris', 'Île-de-France', '75001', 'FR', 1),
  (4, 4, 'ENTREGA', '2-8-1 Shibuya', 'Tokyo', 'Tokyo', '150-0002', 'JP', 1);

-- Atualizando os registros de clientes/vendas.
UPDATE vendas SET cliente_id = 1 WHERE venda_id IN (7002, 7007, 7012);
UPDATE vendas SET cliente_id = 2 WHERE venda_id IN (7022, 7027);
UPDATE vendas SET cliente_id = 3 WHERE venda_id IN (7037, 7042);
UPDATE vendas SET cliente_id = 4 WHERE venda_id IN (7048, 7051);

INSERT INTO pagamentos (pagamento_id, venda_id, data_pagamento, valor, moeda, forma_pagamento_id, status_pagamento_id, referencia_transacao) VALUES
  (1, 7002, '2023-01-22 14:10:00', 520.72, 'USD', 1, 2, 'PAY-7002'),
  (2, 7007, '2023-04-27 10:30:00', 66644.31, 'USD', 2, 2, 'PAY-7007'),
  (3, 7022, '2024-02-06 16:05:00', 9078.68, 'USD', 1, 2, 'PAY-7022'),
  (4, 7037, '2024-11-17 11:40:00', 4217.44, 'USD', 5, 2, 'PAY-7037'),
  (5, 7048, NULL, 401.50, 'USD', 3, 1, 'PAY-7048');

INSERT INTO entregas (entrega_id, venda_id, endereco_cliente_id, transportadora, codigo_rastreio, data_postagem, data_entrega, status_entrega_id) VALUES
  (1, 7002, 1, 'Flash Logistics', 'FL-7002', '2023-01-23', '2023-01-25', 3),
  (2, 7007, 1, 'Flash Logistics', 'FL-7007', '2023-04-28', '2023-05-02', 3),
  (3, 7022, 2, 'Correio Expresso', 'CE-7022', '2024-02-07', '2024-02-12', 3),
  (4, 7037, 3, 'Europa Parcel', 'EP-7037', '2024-11-18', '2024-11-22', 3),
  (5, 7048, 4, 'Tokyo Courier', 'TC-7048', NULL, NULL, 1);

INSERT INTO fornecedores (fornecedor_id, razao_social, email, telefone, pais_id, ativo) VALUES
  (1, 'Stark Props Supply', 'comercial@starkprops.example', '+1-555-8101', 'US', 1),
  (2, 'Artes Místicas Brasil', 'vendas@artesmisticas.example', '+55-11-5555-8102', 'BR', 1),
  (3, 'Kyoto Collectibles', 'sales@kyotocollectibles.example', '+81-3-5555-8103', 'JP', 1);

INSERT INTO fornecedores_produtos (fornecedor_id, produto_id, sku_fornecedor, custo_unitario, moeda) VALUES
  (1, 1, 'SP-POP-001', 180.00, 'USD'),
  (1, 3, 'SP-WEB-001', 140.00, 'USD'),
  (2, 25, 'AMB-DC-003', 820.00, 'BRL'),
  (3, 15, 'KC-PKM-002', 120.00, 'USD'),
  (3, 20, 'KC-ZEL-001', 1100.00, 'USD');

INSERT INTO movimentacoes_estoque (movimentacao_id, produto_id, escritorio_id, data_movimentacao, tipo_movimentacao_estoque_id, quantidade, referencia) VALUES
  (1, 1, 1400, '2025-07-01 09:00:00', 1, 40, 'COMPRA-2025-001'),
  (2, 1, 1400, '2025-07-10 14:00:00', 2, 4, 'PEDIDO-7051'),
  (3, 15, 3000, '2025-07-05 10:30:00', 1, 25, 'COMPRA-2025-002'),
  (4, 20, 3000, '2025-07-08 16:20:00', 3, 2, 'INVENTARIO-2025-07'),
  (5, 25, 2800, '2025-07-12 11:15:00', 1, 12, 'COMPRA-2025-003');

INSERT INTO historico_precos_produto (preco_id, produto_id, preco, moeda, inicio_vigencia, fim_vigencia) VALUES
  (1, 1, 280.00, 'USD', '2024-01-01', '2024-12-31'),
  (2, 1, 300.13, 'USD', '2025-01-01', NULL),
  (3, 15, 180.00, 'USD', '2024-01-01', '2024-12-31'),
  (4, 15, 200.00, 'USD', '2025-01-01', NULL),
  (5, 25, 1200.00, 'USD', '2025-01-01', NULL);

INSERT INTO cursos (curso_id, curso_nome, carga_horaria, nivel_curso_id, ativo) VALUES
  (1, 'Tecnologia Criativa', 80, 1, 1),
  (2, 'Narrativas e Cultura Pop', 60, 2, 1),
  (3, 'Laboratório de Dados', 100, 3, 1);

INSERT INTO turmas (turma_id, curso_id, codigo, data_inicio, data_fim, capacidade, professor_funcionario_id, escritorio_id) VALUES
  (1, 1, 'TEC-2025-01', '2025-02-03', '2025-04-25', 30, 176, 3000),
  (2, 2, 'NAR-2025-01', '2025-03-10', '2025-05-30', 25, 180, 4500),
  (3, 3, 'DAD-2025-01', '2025-06-02', '2025-08-29', 20, 187, 1300);

INSERT INTO alunos (aluno_id, nome, email, data_nascimento, data_cadastro, status_aluno_id) VALUES
  (1, 'Ariel Nunes', 'ariel.nunes@aluno.momento.edu', '2002-05-14', '2025-01-10', 3),
  (2, 'Joana Lee', 'joana.lee@aluno.momento.edu', '2001-08-22', '2025-01-12', 3),
  (3, 'Diego Ramos', 'diego.ramos@aluno.momento.edu', '2003-02-09', '2025-02-01', 1),
  (4, 'Maya Dupont', 'maya.dupont@aluno.momento.edu', '2000-11-30', '2025-05-20', 1);

INSERT INTO matriculas (matricula_id, aluno_id, turma_id, data_matricula, status_matricula_id, nota_final, certificado_emitido) VALUES
  (1, 1, 1, '2025-01-15', 3, 91.50, 1),
  (2, 2, 1, '2025-01-16', 3, 86.00, 1),
  (3, 3, 2, '2025-02-20', 1, NULL, 0),
  (4, 4, 3, '2025-05-22', 1, NULL, 0);

INSERT INTO bolsas (bolsa_id, aluno_id, curso_id, percentual_desconto, criterio, data_concessao) VALUES
  (1, 1, 1, 100.00, 'Bolsa de acesso para formação em tecnologia', '2025-01-12'),
  (2, 3, 2, 50.00, 'Bolsa de diversidade e inclusão', '2025-02-18');

-- Ariel concluiu o curso e ingressou na empresa; o vínculo conserva essa origem.
INSERT INTO funcionarios
  (funcionario_id, primeiro_nome, sobrenome, email, telefone, data_contratacao, cargo_id, salario, moeda_salario, gerente_id, departamento_id, status_funcionario_id)
VALUES
  (300, 'Ariel', 'Nunes', 'ariel.nunes@momento.org', '+1-555-9200', '2025-05-12', 9, 5200.00, 'USD', 103, 6, 1);

INSERT INTO vinculos_talentos (vinculo_id, aluno_id, funcionario_id, departamento_id, tipo_vinculo_id, data_inicio, data_fim, status_vinculo_id) VALUES
  (1, 1, NULL, 6, 1, '2025-05-05', '2025-05-11', 2),
  (2, 1, 300, 6, 2, '2025-05-12', NULL, 1);

