.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

-- O número de encomendas feitas a uma determinada loja esta ano. --

SELECT count(*)
FROM Loja
INNER JOIN Encomenda ON (Loja.id = Encomenda.id_loja)
WHERE 
  Loja.id = 4 AND
  strftime('%Y', data_emissao) = strftime('%Y', date('now'))

