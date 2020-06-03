PRAGMA foreign_keys = ON;

-- Deve ser feita uma encomenda dos produtos marcado para auto renovação
-- quando a sua quantidade em stock é baixa demais (abaixo do threshold
-- definido pelo utilizador). A encomenda deve ser feita na loja em que
-- o utilizador costuma comprar esse produto.

CREATE TRIGGER RetirarProdDespensa
AFTER UPDATE OF quant ON UnidadesProduto
FOR EACH ROW
WHEN
    New.quant< NEW.min_quant AND
    New.autorenovacao IS TRUE
BEGIN
    INSERT INTO Encomenda(data_emissao, id_despensa, id_loja)
    SELECT date('now'), New.id_despensa, Loja.id
        -- Loja onde a encomenda mais recente foi feita a um produto
        FROM Loja INNER JOIN Encomenda ON(Encomenda.id_loja = Loja.id)
        WHERE Encomenda.id IN(
            -- Encomendas que têm o produto
            SELECT Encomenda.id
            FROM Encomenda INNER JOIN QuantidadeProd ON(Encomenda.id = QuantidadeProd.id_encomenda)
            WHERE(QuantidadeProd.id_produto = New.id_produto)
        )
        ORDER BY Encomenda.data_emissao DESC
        LIMIT 1;
    
    INSERT INTO QuantidadeProd(id_produto, id_encomenda, quant_unidade, quant_peso)
    SELECT New.id_produto, last_insert_rowid(), New.min_quant - New.quant, NULL;

    UPDATE UnidadesProduto
    SET quant = New.min_quant
    WHERE UnidadesProduto.rowid = New.rowid;
END;
