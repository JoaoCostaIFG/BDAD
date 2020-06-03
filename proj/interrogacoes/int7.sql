.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- Percentagem de produtos iguais presentes nas despensas de dois dados utilizadores, A e B. --

DROP VIEW IF EXISTS ProdutosUniao;
DROP VIEW IF EXISTS ProdutosIntersecao;

-- Todos produtos nas despensas dos dois utilizadores a verificar (não
-- necessariamente em comum)
CREATE VIEW ProdutosUniao AS
SELECT count(Despensa.nome) as cnt
FROM
  Despensa
  INNER JOIN UnidadesProduto ON (Despensa.id = UnidadesProduto.id_despensa)
  INNER JOIN Produto ON (UnidadesProduto.id_produto = Produto.id)
WHERE
  Despensa.nome = "Despensa da família Duartina" OR
  Despensa.nome = "Despensa da Cantina da FEUP"
;

CREATE VIEW ProdutosIntersecao AS
SELECT count(Produto.nome) as cnt
FROM
  Despensa as D1
  INNER JOIN Despensa as D2 ON (D1.nome = "Despensa da família Duartina" AND
                                D2.nome = "Despensa da Cantina da FEUP")
  INNER JOIN UnidadesProduto as U1 ON (D1.id = U1.id_despensa)
  INNER JOIN UnidadesProduto as U2 ON (D2.id = U2.id_despensa)
  INNER JOIN Produto ON (Produto.id = U1.id_produto AND
                          U1.id_produto = U2.id_produto)
;

SELECT (100.0 * ProdutosIntersecao.cnt / ProdutosUniao.cnt) || ' %' as ProdutosComum
FROM
  ProdutosUniao,
  ProdutosIntersecao
;
