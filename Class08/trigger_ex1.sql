DROP TRIGGER IF EXISTS MARCATRIG;

CREATE TRIGGER MARCATRIG
  INSTEAD OF INSERT ON Reparacao
For Each Row
WHEN idCliente = NULL
BEGIN
  INSERT INTO Reparacao (dataInicio, dataFim, idCarro, idCliente)
  VALUES (New.dataInicio, New.dataFim, New.idCarro,
    (SELECT idCliente
    FROM Carro
    WHERE New.idCarro = idCarro)
  )
END;
