DROP TRIGGER IF EXISTS C;

CREATE TRIGGER C
AFTER INSERT ON ReparacaoPeca
FOR EACH ROW
BEGIN
    UPDATE Peca
    SET quantidade =
        (CASE 
            WHEN quantidade - New.quantidade < 0 
                THEN 0 
            ELSE quantidade - New.quantidade 
        END)
    WHERE New.idPeca = Peca.idPeca;
END;
