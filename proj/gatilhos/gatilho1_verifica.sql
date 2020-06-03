.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

DROP VIEW IF EXISTS DespensaAtualizar;
CREATE VIEW DespensaAtualizar AS
SELECT Despensa.id FROM Despensa
WHERE Despensa.nome = "Despensa da Cantina da FEUP";

DROP VIEW IF EXISTS ProdutoAtualizar;
CREATE VIEW ProdutoAtualizar AS
SELECT Produto.id, Produto.nome FROM Produto
WHERE Produto.nome = "pera rocha";

-- Listar info do produto
SELECT ProdutoAtualizar.nome, UnidadesProduto.quant,
UnidadesProduto.min_quant, UnidadesProduto.autorenovacao
FROM UnidadesProduto
INNER JOIN DespensaAtualizar ON(UnidadesProduto.id_despensa = DespensaAtualizar.id)
INNER JOIN ProdutoAtualizar ON(UnidadesProduto.id_produto = ProdutoAtualizar.id);
-- Listar encomendas da despensa
SELECT Encomenda.id, Encomenda.data_emissao
FROM DespensaAtualizar INNER JOIN Encomenda ON(Encomenda.id_despensa = DespensaAtualizar.id);

-- Update da quantidade
UPDATE UnidadesProduto
SET quant = 2
WHERE UnidadesProduto.id_despensa = (SELECT DespensaAtualizar.id FROM DespensaAtualizar) AND
UnidadesProduto.id_produto = (SELECT ProdutoAtualizar.id FROM ProdutoAtualizar);

SELECT "------------------";
-- Listar info do produto
SELECT ProdutoAtualizar.nome, UnidadesProduto.quant,
UnidadesProduto.min_quant, UnidadesProduto.autorenovacao
FROM UnidadesProduto
INNER JOIN DespensaAtualizar ON(UnidadesProduto.id_despensa = DespensaAtualizar.id)
INNER JOIN ProdutoAtualizar ON(UnidadesProduto.id_produto = ProdutoAtualizar.id);
-- Listar encomendas da despensa
SELECT Encomenda.id, Encomenda.data_emissao
FROM DespensaAtualizar INNER JOIN Encomenda ON(Encomenda.id_despensa = DespensaAtualizar.id);
-- Listar produto adicionado à encomenda adicionada
SELECT QuantidadeProd.id_encomenda, QuantidadeProd.id_produto, quant_unidade, quant_peso
FROM QuantidadeProd
INNER JOIN Encomenda ON Encomenda.data_emissao = date('now') AND Encomenda.id = QuantidadeProd.id_encomenda
