.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- Em qual loja é que um dado utilizador gastou mais dinheiro em encomendas. --

SELECT
	Loja.id AS IdLoja,
	Loja.nome AS NomeLoja,
	SUM (
		IFNULL (
			QuantidadeProd.quant_unidade,
			QuantidadeProd.quant_peso / Produto.peso_medio
		) * InfoProduto.preco *
		IFNULL (
			(
				SELECT (1 - MAX(LojaProdutoDesconto.desconto) / 100.0)
				FROM LojaProdutoDesconto
				WHERE
					Filtered.id_produto = LojaProdutoDesconto.id_produto AND
					Filtered.id_loja = LojaProdutoDesconto.id_loja AND
					date(LojaProdutoDesconto.data_inicio) < date(Filtered.data_emissao) AND
					(
						LojaProdutoDesconto.data_fim IS NULL OR
						date(LojaProdutoDesconto.data_fim) > date(Filtered.data_emissao)
					)
			), 1
		)
	) AS total_gasto
FROM (
	Encomenda
	INNER JOIN Despensa ON (Despensa.nome = "Despensa da Cantina da FEUP" AND Encomenda.id_despensa = Despensa.id)
    INNER JOIN QuantidadeProd ON Encomenda.id = QuantidadeProd.id_encomenda
    INNER JOIN Loja ON Encomenda.id_loja = Loja.id
	INNER JOIN InfoProduto USING (id_produto, id_loja)
	INNER JOIN Produto ON id_produto = Produto.id
) AS Filtered
GROUP BY
	IdLoja
ORDER BY
	total_gasto DESC
LIMIT 3
;
