-- 1. Uma classe é um descritor de um conjunto de objetos que partilham as mesmas propriedades.
-- 3.
-- 4.
CREATE TABLE Pessoa (
  idPessoa INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT,
  NIF TEXT,
  morada TEXT
);

CREATE TABLE Socio (
  idSocio INTEGER PRIMARY KEY AUTOINCREMENT;
  nrSoc INTEGER,
  dataNasc DATE,
  morada TEXT
  idPessoa INTEGER REFERENCES Pessoa(idPessoa)
);

-- 5. pi a,b T1 infinito ró c='Ola' T2
-- 6. Triggers do tipo INSTEAD OF sao usados com views
-- 8. Controlo de concorrencia por bloqueios -> Transacoes
-- 9. CAP : consistência, disponibilidade, tolerancia particional
-- 10. Estrela armazem de dados : só uma tabela cuja chave primaria é constituida pelas chaves externas para cada uma das tabelas dimensão do esquema

-- R(A,B,C,D,E,F) : A -> B ; B -> CD ; AD -> E
-- 11.
Chave da relação: AF

A -> B : {A}+ = {A} : é essencial
B -> C : {B}+ = {B} : é essencial
B -> D : {B}+ = {B} : é essencial
AD -> E : {AD}+ = {ADBCE} : não é essencial

removendo A, {D}+ = {D}
removendo D, {A}+ = {ABCDE}
portanto, D é irrelevante, chegamos a E com ou sem ele

Forma minimal das dependencias funcionais
A -> B
B -> C
B -> D
A -> E

Decomposição na 3FN
R1(A_,B,E)
R2(B_,C,D)
R3(A_,F)

-- 12. FNBC : superchave tem que estar sempre no lado esquerdo da dependencia funcional, todas verificam

SELECT Photo.caption AS "caption"
FROM Photo, User
WHERE User.name = "Daniel Ramos" AND Photo.user = User.id AND
julianday(Photo.uploadDate) - julianday(Photo.creationDate) = 2;

SELECT DISTINCT User.name AS "name"
FROM User, Photo
WHERE User.id NOT IN (
  SELECT User
  FROM Photo
);

--

SELECT avg(users) AS "Media"
FROM (
  SELECT AppearsIn.photo, count(AppearsIn.user) as users
  FROM AppearsIn
  WHERE AppearsIn.photo IN (
    SELECT Likes.photo
    FROM Likes
    GROUP BY Likes.photo
    HAVING count(Likes.user) > 3
  )
  GROUP BY AppearsIn.photo
);

--

DROP VIEW IF EXISTS friend1;
CREATE VIEW friend1 AS
SELECT Friend.user2 AS user
FROM User, Friend
WHERE User.name = "Daniel Ramos" AND Friend.user1 = User.id;

DROP VIEW IF EXISTS friend2;
CREATE VIEW friend2 AS
SELECT Friend.user2
FROM friend1, Friend
WHERE friend1.user = Friend.user1;

SELECT DISTINCT Photo.caption AS "caption"
FROM Photo, AppearsIn
WHERE AppearsIn.photo = Photo.id AND (AppearsIn.user IN friend1 OR AppearsIn.user IN friend2);

--

DELETE FROM Photo
WHERE uploadDate < "2010-01-10" AND Photo.id IN (
  SELECT AppearsIn.photo
  FROM AppearsIn
  GROUP BY AppearsIn.photo
  HAVING count(AppearsIn.user) < 2
);

--

CREATE TRIGGER likePhoto
AFTER INSERT ON AppearsIn
FOR EACH ROW
WHEN (
  SELECT Likes.user
  FROM Likes
  WHERE New.user = Likes.user AND New.Photo = Likes.photo
) IS NULL
BEGIN
    INSERT INTO Likes VALUES (New.user, New.photo);
END;
