# FICHA 2

a) Quais as peças com custo unitário inferior a 10€ e cujo código contém ‘98’?

SELECT * FROM Peca where custoUnitario < 10 and codigo like '%98%';

b) Quais as matrículas dos carros que foram reparados no mês de Setembro de
2010, i.e., cuja reparação terminou nesse mês? 

SELECT matricula
FROM Carro
where idCarro IN
  (SELECT idCarro
    FROM Reparacao
    WHERE dataInicio >= '2010-09-01' and '2010-09-30' >= dataFim);

c) Quais os nomes dos clientes proprietários de carros que utilizaram peças 
com custo unitário superior a 10€? Apresente o resultado ordenado por 
ordem descendente do custo unitário. 

SELECT Cliente.idCliente, nome
FROM Cliente
WHERE idCliente IN (
  SELECT Carro.idCliente
  FROM Carro, Reparacao, ReparacaoPeca, Peca
  WHERE custoUnitario > 10
  and ReparacaoPeca.idPeca = Peca.idPeca
  and ReparacaoPeca.idReparacao = Reparacao.idReparacao
  and Reparacao.idCarro = Carro.idCarro
  ORDER BY custoUnitario DESC);

d) Quais os nomes dos clientes que não têm (tanto quanto se saiba) carro?

SELECT idCliente, nome
FROM Cliente
WHERE idCliente NOT IN (
  SELECT idCliente
  FROM Carro);

e) Qual o número de reparações feitas a cada carro?

SELECT Carro.idCarro, COUNT(DISTINCT Reparacao.idReparacao)
FROM Carro LEFT JOIN Reparacao USING (idCarro)
GROUP BY Carro.idCarro;

f) Qual o número de dias em que cada carro esteve em reparação?

SELECT Carro.idCarro, COUNT(DISTINCT Reparacao.idReparacao), julianday(dataFim) - julianday(dataInicio)
FROM Carro LEFT JOIN Reparacao USING (idCarro)
GROUP BY Carro.idCarro;

g) Qual o custo unitário médio, o valor total e o número de unidades das peças, 
bem como o valor da peça mais cara e da mais barata? 

h) Qual a especialidade que foi utilizada mais vezes nas reparações dos carros.

i) Qual o preço total de cada reparação?

j) Qual o preço total das reparações com custo total superior a 60€?

k) Qual o proprietário do carro que teve a reparação mais cara?

l) Qual a matrícula do carro com a segunda reparação mais cara?

SELECT matricula, sum(Peca.custoUnitario * ReparacaoPeca.quantidade)
FROM Carro, ReparacaoPeca, Reparacao, Peca
WHERE Reparacao.idReparacao = ReparacaoPeca.idReparacao
and Peca.idPeca = ReparacaoPeca.idPeca
and Carro.idCarro = Reparacao.idCarro
GROUP BY Reparacao.idReparacao;

m) Quais são as três reparações mais caras (ordenadas por ordem decrescente
de preço)?

