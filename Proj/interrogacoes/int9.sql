.mode columns 
.headers on 
.nullvalue NULL

-- Listar as encomendas em que todos os produtos estiveram associados a um desconto. --

SELECT Encomenda.id, COUNT(DISTINCT QuantidadeProd.id_produto) AS discounted
FROM (
  -- seleciona todos os produtos encomendados numa encomenda, agrupando-os por encomenda
  Encomenda
  INNER JOIN Despensa ON (Encomenda.id_despensa = Despensa.id)
  INNER JOIN QuantidadeProd ON (Encomenda.id = QuantidadeProd.id_encomenda)
) AS AllEntries
GROUP BY
  Encomenda.id

-- Se o numero de produtos dentro de uma encomenda for igual ao numero de produtos
-- em desconto dentro dessa mesma encomenda, todos os produtos estão em desconto.
INTERSECT

SELECT Encomenda.id, COUNT(DISTINCT QuantidadeProd.id_produto) AS discounted
FROM (
  Encomenda 
  INNER JOIN Despensa ON (Encomenda.id_despensa = Despensa.id)
  INNER JOIN QuantidadeProd ON (Encomenda.id = QuantidadeProd.id_encomenda)
  INNER JOIN Loja ON (Encomenda.id_loja = Loja.id)
) AS Filtered
WHERE (
  -- seleciona todos os produtos em desconto que respeitam as condições (do from acima):
  -- - fazem parte da encomenda a testar
  -- - foram encomendados pela despensa da encomenda a testar
  -- - foram comprados na loja em que a encomenda foi feita
  SELECT 1
  FROM LojaProdutoDesconto
  WHERE
    Filtered.id_produto = LojaProdutoDesconto.id_produto AND
    Filtered.id_loja = LojaProdutoDesconto.id_loja AND
    date(LojaProdutoDesconto.data_inicio) < date(Filtered.data_emissao) AND
    (
      LojaProdutoDesconto.data_fim IS NULL OR
      date(LojaProdutoDesconto.data_fim) > date(Filtered.data_emissao)
    )
  LIMIT 1
)
GROUP BY
  Encomenda.id
;
