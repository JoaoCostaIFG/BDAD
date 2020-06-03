.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- As lojas em que uma dada encomenda ficaria mais barata (na sua
-- totalidade). São listadas as 10 melhores opções por ordem crescente de custo.

DROP VIEW IF EXISTS ProdutosEncomenda;

CREATE VIEW ProdutosEncomenda AS
  SELECT Produto.nome,
      QuantidadeProd.id_encomenda,
      Produto.id AS id_produto,
      IFNULL(QuantidadeProd.quant_unidade, QuantidadeProd.quant_peso / Produto.peso_medio) AS unidades
  FROM QuantidadeProd
    INNER JOIN Produto ON (Produto.id = QuantidadeProd.id_produto)
    INNER JOIN Encomenda ON (Encomenda.id = QuantidadeProd.id_encomenda)
  WHERE
    Encomenda.id = 1;  -- <-- input


WITH LojaProdutoSemDesconto as ( -- Selecionar lojas que têm todos os produtos da encomenda
    SELECT Loja.id as id_loja, Loja.nome, ProdutosEncomenda.id_produto, ProdutosEncomenda.unidades
    FROM Loja, ProdutosEncomenda
    WHERE
      -- Todas as lojas não têm todos os produtos da encomenda
      Loja.id NOT IN (
        SELECT Loja.id
        FROM Loja, Produto
        WHERE
          Produto.id IN (SELECT id_produto FROM ProdutosEncomenda) AND
          Produto.id NOT IN (
            SELECT InfoProduto.id_produto
            FROM InfoProduto
            WHERE
              InfoProduto.id_loja = Loja.id AND
              InfoProduto.id_produto = Produto.id
          )
      )
)
SELECT id_loja, sum(final_price) as total -- Calcular valor total da encomenda para cada loja
FROM ( -- Para cada loja e para cada produto nessa loja ver o maior desconto para esse produto
    SELECT LojaProd.id_loja, nome, LojaProd.id_produto, InfoProduto.preco,
        IFNULL(1 - max(desconto)/100.0, 1) * LojaProd.unidades * InfoProduto.preco as final_price
    FROM LojaProdutoSemDesconto as LojaProd
    INNER JOIN InfoProduto USING(id_loja, id_produto)
    LEFT JOIN LojaProdutoCurrDesconto AS LojaProdDesc USING(id_produto, id_loja)
    GROUP BY id_loja, id_produto
)
GROUP BY id_loja
ORDER BY total ASC;

DROP VIEW IF EXISTS ProdutosEncomenda;
