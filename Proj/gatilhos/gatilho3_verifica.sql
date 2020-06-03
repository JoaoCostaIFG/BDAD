--  .mode columns Com isto ligado n dá para ver nome de lojas na totalidade
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

SELECT CadeiaLojas.nome, CadeiaDesconto.id_desconto
FROM CadeiaDesconto
INNER JOIN CadeiaLojas ON(CadeiaLojas.id = CadeiaDesconto.id_cadeia);

SELECT Loja.nome, LojaDesconto.id_desconto
FROM LojaDesconto INNER JOIN Loja ON(LojaDesconto.id_loja = Loja.id);

DELETE FROM CadeiaLojas
WHERE CadeiaLojas.nome = "Continente";
.headers off
SELECT '----------------------------';
.headers on

SELECT CadeiaLojas.nome, CadeiaDesconto.id_desconto
FROM CadeiaDesconto
INNER JOIN CadeiaLojas ON(CadeiaLojas.id = CadeiaDesconto.id_cadeia);

SELECT Loja.nome, LojaDesconto.id_desconto
FROM LojaDesconto INNER JOIN Loja ON(LojaDesconto.id_loja = Loja.id);
