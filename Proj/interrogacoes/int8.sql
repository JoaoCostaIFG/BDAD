.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- Os produtos em desconto na loja favorita de um utilizador (aquela em que
-- fez mais compras).

WITH LojaFavorita AS (
  SELECT id, id_cadeia
  FROM(
    SELECT Encomenda.id_loja as id, count(Encomenda.id_loja) as lojaCnt
    FROM Encomenda, Despensa
    WHERE Despensa.nome = 'Despensa da Cantina da FEUP'
    --  WHERE Despensa.nome = 'Despensa da família Duartina'
    AND Encomenda.id_despensa = Despensa.id
    GROUP BY Encomenda.id_loja
  ) INNER JOIN Loja USING(id)
  ORDER BY lojaCnt DESC
  LIMIT 1
)
SELECT
  Produto.id,
  Produto.nome,
  max(desconto),
  LojaProdutoCurrDesconto.data_fim
FROM LojaProdutoCurrDesconto
  INNER JOIN LojaFavorita ON (LojaFavorita.id = LojaProdutoCurrDesconto.id_loja)
  INNER JOIN Produto ON (LojaProdutoCurrDesconto.id_produto = Produto.id)
GROUP BY
  Produto.id
ORDER BY
  desconto DESC;
