-- Seleciona a base de dados que será utilizada
USE vendas;

-- Cria a tabela duplicata
CREATE TABLE duplicata (
    nome VARCHAR(40),
    numero INTEGER NOT NULL PRIMARY KEY,
    valor DECIMAL(10,2),
    vencimento DATE,
    banco VARCHAR(50)
);

-- Insere os registos na tabela
INSERT INTO duplicata (nome, numero, valor, vencimento, banco) VALUES
('ABC PAPELARIA', 100100, 5000.00, '2017-01-20', 'ITAÚ'),
('LIVRARIA FERNANDES', 100110, 2500.00, '2017-01-22', 'ITAÚ'),
('LIVRARIA FERNANDES', 100120, 1500.00, '2016-10-15', 'BRADESCO'),
('ABC PAPELARIA', 100130, 8000.00, '2016-10-15', 'SANTANDER'),
('LER E SABER', 200120, 10500.00, '2018-04-26', 'BANCO DO BRASIL'),
('LIVROS E CIA', 200125, 2000.00, '2018-04-26', 'BANCO DO BRASIL'),
('LRE E SABER', 200130, 1100.00, '2018-09-26', 'ITAÚ'),
('PAPELARIA SILVA', 250350, 1500.00, '2018-01-26', 'BRADESCO'),
('LIVROS MM', 250360, 5000.00, '2018-12-18', 'SANTANDER'),
('LIVROS MM', 250370, 3400.00, '2018-04-26', 'SANTANDER'),
('PAPELARIA SILVA', 250380, 3500.00, '2018-04-26', 'BANCO DO BRASIL'),
('LIVROS E CIA', 455360, 1500.00, '2018-06-15', 'ITAÚ'),
('LIVROS MM', 453365, 5400.00, '2018-06-15', 'BRADESCO'),
('PAPELARIA SILVA', 453370, 2350.00, '2017-12-27', 'ITAÚ'),
('LIVROS E CIA', 453380, 1550.00, '2017-12-27', 'BANCO DO BRASIL'),
('ABC PAPELARIA', 980130, 4000.00, '2016-12-11', 'ITAÚ'),
('LIVRARIA FERNANDES', 770710, 2500.00, '2016-11-15', 'SANTANDER'),
('ABC PAPELARIA', 985001, 3000.00, '2016-09-11', 'ITAÚ'),
('PAPEL E AFINS', 985002, 2500.00, '2016-03-12', 'SANTANDER'),
('LER E SABER', 888132, 2500.00, '2017-03-05', 'ITAÚ');

-- Exibe nome, data de vencimento e valor das duplicatas
SELECT nome, vencimento, valor
FROM duplicata;

-- Lista os números das duplicatas do banco Itaú
SELECT banco, numero
FROM duplicata
WHERE banco = 'ITAÚ';

-- Exibe as duplicatas com vencimento em 2017
SELECT *
FROM duplicata
WHERE YEAR(vencimento) = 2017;

-- Exibe duplicatas dos bancos Banco do Brasil e Bradesco
SELECT numero, vencimento, valor, nome
FROM duplicata
WHERE banco IN ('BANCO DO BRASIL', 'BRADESCO');

-- Soma o valor total das duplicatas da Papelaria Silva
SELECT SUM(valor) AS TOTAL_VALOR
FROM duplicata
WHERE nome = 'PAPELARIA SILVA';

-- Remove o registo com número 770710
DELETE FROM duplicata
WHERE numero = 770710;

-- Lista todos os registos ordenados pelo nome
SELECT *
FROM duplicata
ORDER BY nome;

-- Lista todos os registos ordenados pela data de vencimento
SELECT *
FROM duplicata
ORDER BY vencimento;

-- Permite actualizações sem restrições de chave
SET SQL_SAFE_UPDATES = 0;

-- Altera os registos do Banco do Brasil para Santander
UPDATE duplicata
SET banco = 'SANTANDER'
WHERE banco = 'BANCO DO BRASIL';

-- Reativa o modo seguro de actualizações
SET SQL_SAFE_UPDATES = 1;

-- Exibe clientes que possuem duplicatas no Bradesco
SELECT nome, banco
FROM duplicata
WHERE banco = 'BRADESCO';

-- Soma os valores por cliente no ano de 2016
SELECT nome, SUM(valor) AS TOTAL_VALOR_2016
FROM duplicata
WHERE YEAR(vencimento) = 2016
GROUP BY nome;

-- Soma os valores por cliente durante Agosto de 2016
SELECT nome, SUM(valor) AS TOTAL_VALOR_AGOSTO_2016
FROM duplicata
WHERE vencimento >= '2016-08-01'
  AND vencimento <= '2016-08-30'
GROUP BY nome;

-- Calcula multa de 15% para títulos de 2016
SELECT nome, SUM(valor * 0.15) AS MULTA
FROM duplicata
WHERE YEAR(vencimento) = 2016
GROUP BY nome;

-- Calcula multa de 5% para títulos entre Janeiro e Maio de 2017
SELECT nome, SUM(valor * 0.05) AS MULTA
FROM duplicata
WHERE vencimento >= '2017-01-01'
  AND vencimento <= '2017-05-31'
GROUP BY nome;

-- Calcula a média dos valores das duplicatas de 2016
SELECT CONCAT('R$', FORMAT(AVG(valor), 2)) AS MEDIA
FROM duplicata
WHERE YEAR(vencimento) = 2016;

-- Exibe clientes com títulos iguais ou superiores a R$ 10.000
SELECT nome, valor AS VALOR
FROM duplicata
WHERE valor >= 10000;

-- Soma dos valores por cliente no banco Santander
SELECT nome, SUM(valor) AS TOTAL_SANTANDER
FROM duplicata
WHERE banco = 'SANTANDER'
GROUP BY nome;

-- Lista clientes que possuem títulos no Bradesco ou Itaú
SELECT nome AS CLIENTES
FROM duplicata
WHERE banco IN ('BRADESCO', 'ITAÚ');