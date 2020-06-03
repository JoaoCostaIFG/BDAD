.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- Os 3 produtos mais comprados pelas dispensas (em geral). --

SELECT
  Produto.id,
  Produto.nome,
  sum(IFNULL(QuantidadeProd.quant_unidade, QuantidadeProd.quant_peso / Produto.peso_medio)) as summ
FROM Produto
  INNER JOIN QuantidadeProd ON (QuantidadeProd.id_produto = Produto.id)
  INNER JOIN Encomenda ON (QuantidadeProd.id_encomenda = Encomenda.id)
GROUP BY
  Produto.id
ORDER BY
  summ DESC
LIMIT 3
;

