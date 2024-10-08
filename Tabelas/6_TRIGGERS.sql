-- Triggers

-- Trigger são procedimentos armazenados no banco de dados que são automaticamente executados em resposta a determinados eventos em uma tabela ou exibição. Por exemplo, a trigger pode ser acionada quando uma nova linha é inserida em uma tabela.

-- -- Criando uma trigger

CREATE TRIGGER nome_da_trigger
AFTER INSERT ON nome_da_tabela
FOR EACH ROW
EXECUTE FUNCTION nome_da_funcao();

-- -- Exemplo de trigger

CREATE TRIGGER atualiza_data
BEFORE INSERT ON consultas
FOR EACH ROW
EXECUTE FUNCTION atualiza_data();

-- -- Exemplo de função

CREATE FUNCTION atualiza_data()
RETURNS TRIGGER AS $$
BEGIN
    NEW.datahora = NOW();
    RETURN NEW;
END;

-- -- Exemplo de função com condição

CREATE FUNCTION atualiza_data()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.datahora IS NULL THEN
        NEW.datahora = NOW();
    END IF;
    RETURN NEW;
END;

-- -- Exemplo de função com condição e mensagem de erro

CREATE FUNCTION atualiza_data()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.datahora IS NULL THEN
        RAISE EXCEPTION 'A data e hora da consulta não pode ser nula';
    ELSE
        NEW.datahora = NOW();
    END IF;
    RETURN NEW;
END;