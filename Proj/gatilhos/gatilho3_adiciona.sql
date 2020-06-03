PRAGMA foreign_keys = ON;

-- Quando há uma dissolução de uma cadeia de lojas, a cadeia desaparece
-- e as suas lojas tornam-se independentes. Nesta situação, os descontos
-- associados à cadeia passam a estar associados a cada uma dessas lojas.

CREATE TRIGGER DeleteCadeiaDesconto
BEFORE DELETE ON CadeiaLojas
BEGIN
    INSERT INTO LojaDesconto
        SELECT Loja.id, CadeiaDesconto.id_desconto
        FROM Loja
        INNER JOIN CadeiaDesconto ON(CadeiaDesconto.id_cadeia = Old.id)
        WHERE Loja.id_cadeia = Old.id;
END;

