drop table if exists Localidade;
create table Localidade(
    id INTEGER PRIMARY KEY,
    codigo INTEGER NOT NULL CHECK (codigo > 0),
    nome VARCHAR(256) UNIQUE NOT NULL
);

drop table if exists Despensa;
create table Despensa(
    id INTEGER PRIMARY KEY,
    nome VARCHAR(64) UNIQUE NOT NULL,
    morada VARCHAR(64),
    cod_post_fim INTEGER CHECK (cod_post_fim > 0),
    id_localidade INTEGER REFERENCES Localidade ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT sem_morada_despensa CHECK ((morada = NULL and cod_post_fim = NULL
      and id_localidade = NULL) or (morada <> NULL and cod_post_fim <> NULL
      and id_localidade <> NULL))
);

drop table if exists Produto;
create table Produto(
    id INTEGER PRIMARY KEY,
    nome VARCHAR(64) NOT NULL,
    codigo_barras INTEGER UNIQUE,
    peso_medio REAL
);

drop table if exists CategoriaProd;
create table CategoriaProd(
    id INTEGER PRIMARY KEY,
    nome VARCHAR(64) UNIQUE NOT NULL
);

drop table if exists Loja;
create table Loja(
    id INTEGER PRIMARY KEY,
    nome VARCHAR(64) NOT NULL,
    url VARCHAR(256) UNIQUE,
    morada VARCHAR(64),
    id_localidade INTEGER REFERENCES Localidade ON DELETE RESTRICT ON UPDATE CASCADE,
    cod_post_fim INTEGER CHECK (cod_post_fim > 0),
    id_cadeia INTEGER REFERENCES CadeiaLojas ON DELETE SET NULL ON UPDATE CASCADE,

    CONSTRAINT sem_morada_loja CHECK ((morada = NULL and cod_post_fim = NULL
      and id_localidade = NULL) or (morada <> NULL and cod_post_fim <> NULL
      and id_localidade <> NULL)),
    CONSTRAINT parte_de_cadeia CHECK ((url = NULL and id_cadeia = NULL) or
      (url <> NULL and id_cadeia <> NULL))
);

drop table if exists CadeiaLojas;
create table CadeiaLojas(
    id INTEGER PRIMARY KEY,
    nome VARCHAR(64) UNIQUE NOT NULL,
    url VARCHAR(256) UNIQUE NOT NULL
);

drop table if exists Encomenda;
create table Encomenda(
    id INTEGER PRIMARY KEY,
    data_emissao TEXT NOT NULL,
    -- Using now is non-deterministic https://sqlite.org/matrix/deterministic.html --
    -- CONSTRAINT valid_date CHECK (date(data_emissao) <= date('now'))--
    -- will not work --
    -- ok you see GDPR and stuff but we need to keep the records for
    -- 10 years after issuing. Halp // TODO
    id_despensa INTEGER REFERENCES Despensa ON DELETE SET NULL ON UPDATE CASCADE NOT NULL ,
    id_loja INTEGER REFERENCES Loja ON DELETE RESTRICT ON UPDATE CASCADE NOT NULL 
);

drop table if exists Desconto;
create table Desconto(
    id INTEGER PRIMARY KEY,
    percentagem INTEGER NOT NULL CHECK (percentagem <= 100),
    data_inicio TEXT NOT NULL,
    data_fim TEXT,
    CONSTRAINT valid_date CHECK (data_fim = NULL or
      (date(data_fim) >= date(data_inicio)))
);

drop table if exists UnidadesProduto;
create table UnidadesProduto(
    id_despensa INTEGER REFERENCES Despensa ON DELETE CASCADE ON UPDATE CASCADE,
    id_produto INTEGER REFERENCES Produto ON DELETE RESTRICT ON UPDATE CASCADE,
    quant INTEGER NOT NULL CHECK (quant >= 0),
    min_quant INTEGER CHECK (min_quant >= 0),
    autorenovacao BOOLEAN NOT NULL,
    PRIMARY KEY(id_despensa, id_produto)
);

drop table if exists InfoProduto;
create table InfoProduto(
    id_produto INTEGER REFERENCES Produto ON DELETE CASCADE ON UPDATE CASCADE,
    id_loja INTEGER REFERENCES Loja ON DELETE RESTRICT ON UPDATE CASCADE,
    preco REAL NOT NULL CHECK (preco >= 0),
    PRIMARY KEY(id_produto, id_loja)
);

drop table if exists QuantidadeProd;
create table QuantidadeProd(
    id_produto INTEGER REFERENCES Produto ON DELETE RESTRICT ON UPDATE CASCADE,
    id_encomenda INTEGER REFERENCES Encomenda ON DELETE CASCADE ON UPDATE CASCADE,
    quant_unidade INTEGER CHECK (quant_unidade > 0),
    quant_peso REAL CHECK (quant_peso > 0),
    CONSTRAINT quant_peso_ou_unidades CHECK ((quant_unidade = NULL and quant_peso <> NULL) or
      (quant_unidade <> NULL and quant_peso = NULL))
    PRIMARY KEY(id_produto, id_encomenda)
);

drop table if exists Categoria;
create table Categoria(
    id_produto INTEGER REFERENCES Produto ON DELETE CASCADE ON UPDATE CASCADE,
    id_categoria INTEGER REFERENCES CategoriaProd ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_produto, id_categoria)
);

drop table if exists SubCategoria;
create table SubCategoria(
    id_categoria_mae INTEGER REFERENCES CategoriaProd ON DELETE CASCADE ON UPDATE CASCADE,
    id_subcategoria INTEGER REFERENCES CategoriaProd ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_categoria_mae, id_subcategoria)
);

drop table if exists CategoriaDesconto;
create table CategoriaDesconto(
    id_categoria INTEGER REFERENCES CategoriaProd ON DELETE CASCADE ON UPDATE CASCADE,
    id_desconto INTEGER REFERENCES Desconto ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_categoria, id_desconto)
);

drop table if exists ProdutoDesconto;
create table ProdutoDesconto(
    id_produto INTEGER REFERENCES Produto ON DELETE CASCADE ON UPDATE CASCADE,
    id_desconto INTEGER REFERENCES Desconto ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_produto, id_desconto)
);

drop table if exists LojaDesconto;
create table LojaDesconto(
    id_loja INTEGER REFERENCES Loja ON DELETE RESTRICT ON UPDATE CASCADE,
    id_desconto INTEGER REFERENCES Desconto ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY(id_loja, id_desconto)
);

drop table if exists CadeiaDesconto;
create table CadeiaDesconto(
    id_cadeia INTEGER REFERENCES CadeiaLojas ON DELETE CASCADE ON UPDATE CASCADE,
    id_desconto INTEGER REFERENCES Desconto ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY(id_cadeia, id_desconto)
);

DROP VIEW IF EXISTS Descs;
CREATE VIEW Descs AS
    SELECT id_produto, id_categoria, data_inicio, data_fim, id_loja, id_cadeia, percentagem
    FROM Desconto
        LEFT JOIN ProdutoDesconto ON Desconto.id = ProdutoDesconto.id_desconto
        LEFT JOIN CategoriaDesconto ON Desconto.id = CategoriaDesconto.id_desconto
        LEFT JOIN LojaDesconto ON Desconto.id = LojaDesconto.id_desconto
        LEFT JOIN CadeiaDesconto ON Desconto.id = CadeiaDesconto.id_desconto
    WHERE
        (id_produto IS NOT NULL OR id_categoria IS NOT NULL) AND
        (id_loja IS NOT NULL OR id_cadeia IS NOT NULL)
;

DROP VIEW IF EXISTS LojaProdutoDesconto;
CREATE VIEW LojaProdutoDesconto AS
    SELECT Loja.id as id_loja, InfoProduto.id_produto, Desconto.percentagem as desconto, Desconto.data_inicio, Desconto.data_fim
    FROM InfoProduto
    INNER JOIN Loja ON Loja.id = InfoProduto.id_loja AND Loja.id_cadeia is NULL -- Lojas individuais
    INNER JOIN LojaDesconto ON LojaDesconto.id_loja = Loja.id
    INNER JOIN ProdutoDesconto ON ProdutoDesconto.id_produto = InfoProduto.id_produto AND
        ProdutoDesconto.id_desconto = LojaDesconto.id_desconto
    INNER JOIN Desconto ON Desconto.id = ProdutoDesconto.id_desconto
    UNION ALL
    SELECT Loja.id as id_loja, InfoProduto.id_produto, Desconto.percentagem as desconto, Desconto.data_inicio, Desconto.data_fim
    FROM InfoProduto
    INNER JOIN Loja ON Loja.id = InfoProduto.id_loja AND Loja.id_cadeia is NULL -- Lojas individuais
    INNER JOIN Categoria ON Categoria.id_produto = InfoProduto.id_produto
    INNER JOIN LojaDesconto ON LojaDesconto.id_loja = Loja.id
    INNER JOIN CategoriaDesconto ON CategoriaDesconto.id_categoria = Categoria.id_categoria AND
        CategoriaDesconto.id_desconto = LojaDesconto.id_desconto
    INNER JOIN Desconto ON Desconto.id = CategoriaDesconto.id_desconto
    UNION ALL
    SELECT Loja.id as id_loja, InfoProduto.id_produto, Desconto.percentagem as desconto, Desconto.data_inicio, Desconto.data_fim
    FROM InfoProduto
    INNER JOIN Loja ON Loja.id = InfoProduto.id_loja AND Loja.id_cadeia not NULL -- Loja pertence Cadeia
    INNER JOIN CadeiaDesconto ON CadeiaDesconto.id_cadeia = Loja.id_cadeia
    INNER JOIN ProdutoDesconto ON ProdutoDesconto.id_produto = InfoProduto.id_produto AND
        ProdutoDesconto.id_desconto = CadeiaDesconto.id_desconto
    INNER JOIN Desconto ON Desconto.id = ProdutoDesconto.id_desconto
    UNION ALL
    SELECT Loja.id as id_loja, InfoProduto.id_produto, Desconto.percentagem as desconto, Desconto.data_inicio, Desconto.data_fim
    FROM InfoProduto
    INNER JOIN Loja ON Loja.id = InfoProduto.id_loja AND Loja.id_cadeia not NULL -- Lojas pertence Cadeia
    INNER JOIN Categoria ON Categoria.id_produto = InfoProduto.id_produto
    INNER JOIN CadeiaDesconto ON CadeiaDesconto.id_cadeia = Loja.id_cadeia
    INNER JOIN CategoriaDesconto ON CategoriaDesconto.id_categoria = Categoria.id_categoria AND
        CategoriaDesconto.id_desconto = CadeiaDesconto.id_desconto
    INNER JOIN Desconto ON Desconto.id = CategoriaDesconto.id_desconto;

DROP VIEW IF EXISTS LojaProdutoCurrDesconto;
CREATE VIEW LojaProdutoCurrDesconto AS
    SELECT Loja.id as id_loja, InfoProduto.id_produto, Desconto.percentagem as desconto, Desconto.data_inicio, Desconto.data_fim
    FROM InfoProduto
    INNER JOIN Loja ON Loja.id = InfoProduto.id_loja AND Loja.id_cadeia is NULL -- Lojas individuais
    INNER JOIN LojaDesconto ON LojaDesconto.id_loja = Loja.id
    INNER JOIN ProdutoDesconto ON ProdutoDesconto.id_produto = InfoProduto.id_produto AND
        ProdutoDesconto.id_desconto = LojaDesconto.id_desconto
    INNER JOIN Desconto ON Desconto.id = ProdutoDesconto.id_desconto
    WHERE date('now') > date(data_inicio) AND
        (data_fim is NULL OR date('now') < date(data_fim))
    UNION ALL
    SELECT Loja.id as id_loja, InfoProduto.id_produto, Desconto.percentagem as desconto, Desconto.data_inicio, Desconto.data_fim
    FROM InfoProduto
    INNER JOIN Loja ON Loja.id = InfoProduto.id_loja AND Loja.id_cadeia is NULL -- Lojas individuais
    INNER JOIN Categoria ON Categoria.id_produto = InfoProduto.id_produto
    INNER JOIN LojaDesconto ON LojaDesconto.id_loja = Loja.id
    INNER JOIN CategoriaDesconto ON CategoriaDesconto.id_categoria = Categoria.id_categoria AND
        CategoriaDesconto.id_desconto = LojaDesconto.id_desconto
    INNER JOIN Desconto ON Desconto.id = CategoriaDesconto.id_desconto
    WHERE date('now') > date(data_inicio) AND
        (data_fim is NULL OR date('now') < date(data_fim))
    UNION ALL
    SELECT Loja.id as id_loja, InfoProduto.id_produto, Desconto.percentagem as desconto, Desconto.data_inicio, Desconto.data_fim
    FROM InfoProduto
    INNER JOIN Loja ON Loja.id = InfoProduto.id_loja AND Loja.id_cadeia not NULL -- Loja pertence Cadeia
    INNER JOIN CadeiaDesconto ON CadeiaDesconto.id_cadeia = Loja.id_cadeia
    INNER JOIN ProdutoDesconto ON ProdutoDesconto.id_produto = InfoProduto.id_produto AND
        ProdutoDesconto.id_desconto = CadeiaDesconto.id_desconto
    INNER JOIN Desconto ON Desconto.id = ProdutoDesconto.id_desconto
    WHERE date('now') > date(data_inicio) AND
        (data_fim is NULL OR date('now') < date(data_fim))
    UNION ALL
    SELECT Loja.id as id_loja, InfoProduto.id_produto, Desconto.percentagem as desconto, Desconto.data_inicio, Desconto.data_fim
    FROM InfoProduto
    INNER JOIN Loja ON Loja.id = InfoProduto.id_loja AND Loja.id_cadeia not NULL -- Lojas pertence Cadeia
    INNER JOIN Categoria ON Categoria.id_produto = InfoProduto.id_produto
    INNER JOIN CadeiaDesconto ON CadeiaDesconto.id_cadeia = Loja.id_cadeia
    INNER JOIN CategoriaDesconto ON CategoriaDesconto.id_categoria = Categoria.id_categoria AND
        CategoriaDesconto.id_desconto = CadeiaDesconto.id_desconto
    INNER JOIN Desconto ON Desconto.id = CategoriaDesconto.id_desconto
    WHERE date('now') > date(data_inicio) AND
        (data_fim is NULL OR date('now') < date(data_fim));
