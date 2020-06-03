DROP TRIGGER IF EXISTS MARCARCONSULTA;

CREATE TRIGGER MARCARCONSULTA
BEFORE INSERT ON ConsultasMarcadas
WHEN not exists (
  SELECT *
  FROM ConsultasMarcadas, Disponibilidade, HorarioConsultas
  WHERE
    ConsultasMarcadas.codmedico = Disponibilidade.codigo and
    Disponibilidade.idhorarioconsulta = HorarioConsultas.idhorarioconsulta and
    HorarioConsultas.numdoentes > 1 + (
      SELECT COUNT(*)
      FROM ConsultasMarcadas
      WHERE ConsultasMarcadas.codmedico = New.codmedico
    )
)
BEGIN
  SELECT raise(ignore);
END;
