.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- A lista de lojas numa região que têm um dado produto em stock. --

SELECT Loja.nome, Loja.morada, Produto.nome, InfoProduto.preco
FROM Produto
INNER JOIN InfoProduto ON (InfoProduto.id_produto = Produto.id)
INNER JOIN Loja ON (InfoProduto.id_loja = Loja.id)
INNER JOIN Localidade ON (Localidade.id = Loja.id_localidade)
WHERE
  Localidade.nome LIKE '%Porto%' AND
  Produto.nome = 'lixivia 1l'

