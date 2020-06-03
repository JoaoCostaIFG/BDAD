.mode columns 
.headers on 
.nullvalue NULL
PRAGMA foreign_keys = ON;

SELECT "Before Delete";
SELECT * FROM SubCategoria;

SELECT "Deleting category 2, then 10 and then 1";

-- delete cat. 2
DELETE FROM CategoriaProd
WHERE
  id = 2;
SELECT * FROM SubCategoria;

-- delete cat. 10
DELETE FROM CategoriaProd
WHERE
  id = 10;
SELECT * FROM SubCategoria;

-- delete cat. 1
DELETE FROM CategoriaProd
WHERE
  id = 1;
SELECT * FROM SubCategoria;
