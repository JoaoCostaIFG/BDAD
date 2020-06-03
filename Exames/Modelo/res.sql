SELECT Servidor.hostname AS "hostname", Pessoa.nome AS "nome"
FROM Servidor, Pessoa
WHERE Servidor.idResponsavel = Pessoa.idPessoa AND Servidor.vulneravel = "sim";

SELECT Servidor.hostname AS "hostname", Bug.descricao AS "descricao", Pessoa.nome AS "nome"
FROM Servidor, Bug, Pessoa, Aplicacao, AplicacaoServidor
WHERE Bug.idResponsavel = Pessoa.idPessoa AND
Bug.vulnerabilidade = "sim" AND
Aplicacao.idAplicacao = Bug.idAplicacao AND
AplicacaoServidor.idAplicacao = Aplicacao.idAplicacao AND
AplicacaoServidor.idServidor = Servidor.idServidor
ORDER BY Servidor.hostname;

SELECT Servidor.hostname AS "hostname"
FROM Servidor, Pessoa, Bug, AplicacaoServidor
WHERE Servidor.hostname LIKE "alu%" AND
Servidor.idResponsavel = Pessoa.idPessoa AND
Pessoa.mail = "joao.almeida@cica.pt" AND
Bug.idAplicacao = AplicacaoServidor.idAplicacao AND
AplicacaoServidor.idServidor = Servidor.idServidor
GROUP BY Servidor.hostname
HAVING count(*) > 0;

SELECT Aplicacao.nome AS "nome"
FROM Aplicacao, Bug
WHERE Bug.idAplicacao = Aplicacao.idAplicacao
GROUP BY Aplicacao.nome
ORDER BY count(*) DESC
LIMIT 1;

CREATE TRIGGER adicionaApp
AFTER INSERT ON AplicacaoServidor
WHEN EXISTS (
  SELECT *
  FROM Bug, Aplicacao
  WHERE Bug.idAplicacao = Aplicacao.idAplicacao AND
  Bug.vulnerabilidade = "sim" AND
  New.idAplicacao = Aplicacao.idAplicacao
)
BEGIN
    UPDATE Servidor
    SET vulneravel = "sim"
    WHERE Servidor.idServidor = New.idServidor;
END;

CREATE TRIGGER adicionaBug
AFTER INSERT ON Bug
FOR EACH ROW
WHEN New.vulnerabilidade = "sim"
BEGIN
    UPDATE Servidor
    SET vulneravel = "sim"
    WHERE EXISTS (
      SELECT *
      FROM AplicacaoServidor
      WHERE AplicacaoServidor.idAplicacao = New.idAplicacao AND AplicacaoServidor.idServidor = Servidor.idServidor
    );

    UPDATE Bug
    SET prioridade = 1
    WHERE Bug.idBug = New.idBug;
END;
