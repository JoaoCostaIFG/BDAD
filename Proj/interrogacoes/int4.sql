.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- O nome e a quantidade de cada produto adquirido por uma despensa este mês. --

SELECT Produto.nome, count(*)
FROM Despensa
INNER JOIN Encomenda ON (Despensa.id = Encomenda.id_despensa)
INNER JOIN QuantidadeProd ON (QuantidadeProd.id_encomenda = Encomenda.id)
INNER JOIN Produto ON (QuantidadeProd.id_produto = Produto.id)
WHERE
  Despensa.id = 4 AND
  strftime('%m', Encomenda.data_emissao) = strftime('%m', date('now'))
GROUP BY Produto.id

