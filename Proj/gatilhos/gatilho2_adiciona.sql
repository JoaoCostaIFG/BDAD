PRAGMA foreign_keys = ON;

-- Quando uma categoria é eliminada, as suas categorias filhas devem definir
-- as categorias mãe desta categoria como suas novas categorias mãe.

CREATE TRIGGER HerdarCategoria
BEFORE DELETE ON CategoriaProd
FOR EACH ROW
BEGIN
  INSERT INTO SubCategoria (id_categoria_mae, id_subcategoria)
  WITH old_categorias_mae AS (
    SELECT id_categoria_mae
    FROM SubCategoria
    WHERE id_subcategoria = Old.id
  )
  SELECT id_categoria_mae, id_subcategoria
  FROM
    old_categorias_mae
    CROSS JOIN
    (SELECT id_subcategoria
    FROM SubCategoria
    WHERE id_categoria_mae = Old.id)
  ;
END;

