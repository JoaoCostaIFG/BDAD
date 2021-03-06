DROP TABLE IF EXISTS MedicamentoPrescricao;
DROP TABLE IF EXISTS Medicamento;
DROP TABLE IF EXISTS Prescricao;
DROP TABLE IF EXISTS ConsultasMarcadas;
DROP TABLE IF EXISTS Disponibilidade;
DROP TABLE IF EXISTS HorarioConsultas;
DROP TABLE IF EXISTS Doente;
DROP TABLE IF EXISTS Medico;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Especialidade;

CREATE TABLE Especialidade (
	idespec numeric PRIMARY KEY,
	nome TEXT);

CREATE TABLE Pessoa (
	codigo numeric PRIMARY KEY,
	nome TEXT,
	nif TEXT UNIQUE,
	morada TEXT,
	codPostal TEXT,
	telefone TEXT,
	datanasc DATE);

CREATE TABLE Medico (
	codigo numeric PRIMARY KEY REFERENCES Pessoa,
	idespec numeric REFERENCES Especialidade(idespec));

CREATE TABLE Doente (
	codigo numeric PRIMARY KEY REFERENCES Pessoa,
	profissao TEXT);

CREATE TABLE HorarioConsultas (
	idhorarioconsulta numeric PRIMARY KEY,
	horainicio numeric,
	numdoentes numeric);

CREATE TABLE Disponibilidade (
	codigo numeric REFERENCES Medico(codigo),
	dia DATE,
	idhorarioconsulta numeric REFERENCES HorarioConsultas(idhorarioconsulta),
	CONSTRAINT pk_disponibilidade PRIMARY KEY (codigo, dia));

CREATE TABLE ConsultasMarcadas (
	idConsultaMarcada numeric PRIMARY KEY,
	data TEXT,
	horainicio numeric,
	preco numeric,
	relatorio TEXT,
	classificacao TEXT,
	codmedico numeric REFERENCES Medico(codigo),
	coddoente numeric REFERENCES Doente(codigo));

CREATE TABLE Prescricao (
	idprescricao numeric PRIMARY KEY,
	data DATE,
	codmedico numeric REFERENCES Medico(codigo),
	coddoente numeric REFERENCES Doente(codigo));

CREATE TABLE Medicamento (
	idmedicamento numeric PRIMARY KEY,
	nome TEXT,
	laboratorio TEXT,
	modo TEXT,
	quantidade numeric);

CREATE TABLE MedicamentoPrescricao (
	idprescricao numeric REFERENCES Prescricao(idprescricao),
	idmedicamento numeric REFERENCES Medicamento(idmedicamento),
	numembalagens numeric,
	CONSTRAINT pk_prescricaomedicamento PRIMARY KEY (idprescricao, idmedicamento));


INSERT INTO Especialidade (idespec, nome) VALUES (1, 'ortopedia');
INSERT INTO Especialidade (idespec, nome) VALUES (2, 'oftalmologia');
INSERT INTO Especialidade (idespec, nome) VALUES (3, 'otorrinolaringologia');

INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (1, 'Jose Andrade Simoes', '117689827', 'Av. da Republica, 105, Vila do Conde', '4340-121', '936254908', 17-05-1959);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (2, 'Ana Fernandes de Oliveira', '132459827', 'Rua Amalia Rodrigues, 375, 2�Dir, Penafiel', '4500-240', '917689325', 12-12-1965);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (3, 'Fernando Carlos Goncalves Cardoso', '109365809', 'Rua de Timor, 327 1 Esq, Vila Nova de Gaia', '4300-029', '964517329', 03-04-1973);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (4, 'Mariana Guedes de Araujo', '111091452', 'Rua de Recarei, 10, Porto', '4000-350', '925938479', 03-11-1981);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (5, 'Carlos Antunes de Vasconcelos', '129430908', 'Rua Diogo Borges, 102 5 Dir T, Porto', '4000-080', '936254908', 17-05-1959);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (6, 'Marilia de Jesus Almeida', '121110903', 'Carreiro da Lama, 27, Lousada', '4560-390', '912829354', 11-03-1984);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (7, 'Joao Carvalho e Silva', '102394465', 'Rua 15, 372 2 Dir, Espinho', '4600-520', '902009412', 27-02-1952);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (8, 'Armando Botelho Veiga', '101320890', 'Rua da preciosa, 105 2 Dir, Porto', '4200-450', '936254908', 17-05-1959);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (9, 'Belmira de Mesquita Seixas', '121146915', 'Rua da restauracao', '4250-805', '924928356', 19-07-1979);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (10, 'Rui Manuel Alves de Sousa', '105310083', 'Avenida do casino, 110 7 Dir, Povoa de Varzim', '4600-750', '913097891', 07-01-1967);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (11, 'Manuel Veloso Gomes', '100430152', 'Rua de Golgota, 32, Porto', '4000-300', '918276890', 15-06-1984);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (12, 'Ines Salgado Barbosa', '125340728', 'Rua de Timor, 327 3 Esq, Paredes', '4580-730', '923908612', 19-03-1982);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (13, 'Ana Rita Santos Ribeiro', '111525746', 'Av. Julio Pereira, 312, Penafiel', '4560-392', '962305460', 20-10-1966);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (14, 'Rute Lopes Duarte', '107320568', 'Rua 22, 93, Espinho', '4600-320', '924097301', 11-01-1962);
INSERT INTO Pessoa (codigo, nome, nif, morada, codpostal, telefone, datanasc) VALUES (15, 'Luisa Faria Leal', '102560798', 'Rua do Mirante, 200, Porto', '4000-210', '918147275', 02-08-1956);

INSERT INTO Medico (codigo, idespec) VALUES (1,1);
INSERT INTO Medico (codigo, idespec) VALUES (2,1);
INSERT INTO Medico (codigo, idespec) VALUES (3,2);
INSERT INTO Medico (codigo, idespec) VALUES (4,2);
INSERT INTO Medico (codigo, idespec) VALUES (5,2);
INSERT INTO Medico (codigo, idespec) VALUES (6,3);

INSERT INTO Doente (codigo, profissao) VALUES (7,'advogado');
INSERT INTO Doente (codigo, profissao) VALUES (8,'electrecista');
INSERT INTO Doente (codigo, profissao) VALUES (9,'contabilista');
INSERT INTO Doente (codigo, profissao) VALUES (10,'marceneiro');
INSERT INTO Doente (codigo, profissao) VALUES (11,'comerciante');
INSERT INTO Doente (codigo, profissao) VALUES (12,'enfermeiro');
INSERT INTO Doente (codigo, profissao) VALUES (13,'professor');
INSERT INTO Doente (codigo, profissao) VALUES (14,'politico');
INSERT INTO Doente (codigo, profissao) VALUES (15,'taxista');

INSERT INTO HorarioConsultas (idhorarioconsulta, horainicio, numdoentes) VALUES (1, 9.30, 8);
INSERT INTO HorarioConsultas (idhorarioconsulta, horainicio, numdoentes) VALUES (2, 10, 2);
INSERT INTO HorarioConsultas (idhorarioconsulta, horainicio, numdoentes) VALUES (3, 14, 10);
INSERT INTO HorarioConsultas (idhorarioconsulta, horainicio, numdoentes) VALUES (4, 14, 6);

INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (1, 02-05-2017, 1);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (1, 03-05-2017, 1);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (1, 04-05-2017, 1);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (1, 05-05-2017, 1);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (2, 02-05-2017, 2);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (2, 03-05-2017, 2);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (2, 04-05-2017, 3);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (2, 05-05-2017, 2);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (3, 02-05-2017, 3);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (3, 03-05-2017, 3);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (3, 04-05-2017, 3);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (3, 05-05-2017, 3);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (4, 02-05-2017, 1);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (4, 03-05-2017, 1);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (4, 04-05-2017, 2);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (4, 05-05-2017, 2);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (5, 02-05-2017, 2);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (5, 03-05-2017, 3);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (5, 04-05-2017, 2);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (5, 05-05-2017, 2);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (6, 02-05-2017, 4);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (6, 03-05-2017, 4);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (6, 04-05-2017, 4);
INSERT INTO Disponibilidade (codigo, dia, idhorarioconsulta) VALUES (6, 05-05-2017, 4);

INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (1, 02-05-2017, 9.30, 40, 'fisura na tibia esquerda', 'Amarelo', 1, 10);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (2, 02-05-2017, 10, 30, 'entorse do tornozelo direito', 'Amarelo', 1, 12);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (3, 02-05-2017, 11, 40, 'rutura de ligamentos pe direito', 'Vermelho', 1, 13);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (4, 03-05-2017, 10, 40, 'Sindrome de Quervain no pulso esquerdo', 'Verde', 1, 14);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (5, 02-05-2017, 11, 40, 'hipermetropia do olho esquerdo', 'Amarelo', 3, 10);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (6, 05-05-2017, 10, 40, 'hipermetropia do olho esquerdo', 'Amarelo', 5, 9);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (7, 02-05-2017, 11, 40, 'hipermetropia do olho esquerdo', 'Amarelo', 3, 12);
INSERT INTO ConsultasMarcadas (idConsultaMarcada, data, horainicio, preco, relatorio, classificacao, codmedico, coddoente) VALUES (8, 05-05-2017, 10.30, 30, 'hipermetropia do olho esquerdo', 'Amarelo', 5, 13);

INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (1, 02-05-2017, 1, 1);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (2, 02-05-2017, 1, 2);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (3, 02-05-2017, 1, 3);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (4, 03-05-2017, 2, 1);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (5, 03-05-2017, 3, 4);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (6, 04-05-2017, 4, 8);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (7, 05-05-2017, 5, 7);
INSERT INTO Prescricao (idprescricao, data, codmedico, coddoente) VALUES (8, 05-05-2017, 5, 5);

INSERT INTO Medicamento (idmedicamento, nome, laboratorio, modo, quantidade) VALUES (1, 'ben-u-ron', 'bene', 'oral', 10);
INSERT INTO Medicamento (idmedicamento, nome, laboratorio, modo, quantidade) VALUES (2, 'clamoxil', 'SmithKline Beecham Pharmaceuticals', 'oral', 4);

INSERT INTO MedicamentoPrescricao(idprescricao, idmedicamento, numembalagens) VALUES (2, 1, 1);
INSERT INTO MedicamentoPrescricao(idprescricao, idmedicamento, numembalagens) VALUES (1, 2, 1);
INSERT INTO MedicamentoPrescricao(idprescricao, idmedicamento, numembalagens) VALUES (3, 1, 1);
INSERT INTO MedicamentoPrescricao(idprescricao, idmedicamento, numembalagens) VALUES (3, 2, 2);


