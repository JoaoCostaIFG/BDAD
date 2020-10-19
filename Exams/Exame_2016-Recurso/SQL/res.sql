-- 1. hierarquia de classes : conjunto de classes organizadas com base na relação de especialização
-- 2. nem todos os atributos sao atomicos
-- 3. pi a ró c=1 T1 infinito_(T1.a > T2.b) T2
-- 4. chaves externas
-- 8. key value store : uma tabela com 2 colunas, a chave e o valor

R(A,B,C,D,E,F,G,H)
ABC -> DGH
F -> BA
B -> E
D -> H
E -> BC
D -> F

-- 11.
AE -> AEBCDGHF (contem G)
BCD -> BCEHF (contem F)
AC -> AC (nao pode ser obtida)

-- 12.
Para a relação R se encontrar na FNBC o lado esquerdo de todas as dependencias funcionais tem que ser
uma chave da relação.
Chave da relação: {AB} = {AB E C DGH F}
Como o lado esquerdo da DF ABC -> DGH não corresponde à superkey AB existe uma violação de FNBC.

SELECT Estudante.nome AS "Estudante"
FROM Estudante, Curso
WHERE Estudante.nome LIKE "%a%" AND Estudante.curso = Curso.ID AND Curso.nome = "MIEIC";

--

SELECT Estudante.nome AS "nome"
FROM Estudante, Amizade
WHERE Estudante.ID = Amizade.ID1 AND Amizade.ID2 IN (
  SELECT Estudante.ID
  FROM Estudante
  WHERE Estudante.nome LIKE "Gabriel%"
);

--

SELECT E0.nome AS "Nome"
FROM Estudante E0, Estudante E1, Estudante E2, Estudante E3, Estudante E4, Estudante E5,
Amizade A1, Amizade A2, Amizade A3, Amizade A4, Amizade A5
WHERE E0.ID = A1.ID1 AND E0.ID = A2.ID1 AND E0.ID = A3.ID1 AND E0.ID = A4.ID1 AND E0.ID = A5.ID1 AND
E1.ID = A1.ID2 AND E2.ID = A2.ID2 AND E3.ID = A3.ID2 AND E4.ID = A4.ID2 AND E5.ID = A5.ID2 AND
E1.anoCurricular = 1 AND E2.anoCurricular = 2 AND E3.anoCurricular = 3 AND E4.anoCurricular = 4 AND E5.anoCurricular = 5;

--

CREATE TABLE AmizadeTransitiva (
  ID1 int REFERENCES Estudante(ID),
  ID2 int REFERENCES Estudante(ID),
  PRIMARY KEY (ID1, ID2)
);

INSERT INTO AmizadeTransitiva VALUES (
  SELECT DISTINCT A1.ID1, A2.ID2
  FROM Amizade A1, Amizade A2
  WHERE A1.ID2 = A2.ID1
  AND A1.ID1 <> A2.ID2 -- AutoAmizades
  AND A2.ID2 NOT IN (
    SELECT A3.ID2 FROM Amizade A3 WHERE A3.ID1 = A1.ID1
  ) -- Amizades existentes em Amizade
  ORDER BY A1.ID1, A2.ID2;
);

--

SELECT DISTINCT E1.nome AS "Nome", E2.nome AS "Nome"
FROM Estudante E1, Estudante E2, Amizade
WHERE Amizade.ID1 = E1.ID AND Amizade.ID2 = E2.ID AND E1.curso <> E2.curso
ORDER BY E1.nome;
