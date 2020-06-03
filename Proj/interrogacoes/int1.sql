.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- A lista de produtos numa dada despensa e as quantidades em que se encontram. --

SELECT Produto.nome, UnidadesProduto.quant
FROM Despensa
INNER JOIN UnidadesProduto ON (UnidadesProduto.id_despensa = Despensa.id)
INNER JOIN Produto ON (UnidadesProduto.id_produto = Produto.id)

