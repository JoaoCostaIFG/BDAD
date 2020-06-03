PRAGMA foreign_keys = ON;

-- Localidades
INSERT INTO Localidade VALUES (1, 2140, 'Santarém');
INSERT INTO Localidade VALUES (2, 3080, 'Coimbra');
INSERT INTO Localidade VALUES (3, 4050, 'Porto');
INSERT INTO Localidade VALUES (4, 4200, 'Mirandela');
INSERT INTO Localidade VALUES (5, 4520, 'Santa Maria da Feira');
INSERT INTO Localidade VALUES (6, 4634, 'Lisboa');
INSERT INTO Localidade VALUES (7, 4910, 'Viana do Castelo');
INSERT INTO Localidade VALUES (8, 8500, 'Faro');
INSERT INTO Localidade VALUES (9, 4410, 'Arcozelo');

-- Produtos e Categorias
insert into Produto values (11, 'carapau congelado', 37808, 60);
insert into Produto values (15, 'douradinhos congelados',  37809, 28);
insert into Produto values (16, 'azeite galo 1l', 37810, NULL);
insert into Produto values (19, 'batatas fritas lays presunto (grande)', 37811, NULL);
insert into Produto values (22, 'batata vermelha', 37812, 200);
insert into Produto values (36, 'batata congelada para fritar (grande)', 37813, NULL);
insert into Produto values (38, 'pera rocha', 37814, 180);
insert into Produto values (39, 'super bock 33cl', 37815, NULL);
insert into Produto values (40, 'super bock 1l', 37816, NULL);
insert into Produto values (63, 'agua das pedras 33cl', 37817, NULL);
insert into Produto values (64, 'iced tea 1l', 37818, NULL);
insert into Produto values (67, 'vinho do porto', 37819, NULL);
insert into Produto values (68, 'picanha de bovino', 37820, 1650);
insert into Produto values (69, 'champanhe 1l', 37821, NULL);
insert into Produto values (71, 'absinto 1l', 37832, NULL);
insert into Produto values (72, 'compal de maracuja 33cl', 37823, NULL);
insert into Produto values (73, 'yogurt natural', 37824, 125);
insert into Produto values (74, 'pao da avo', 37825, NULL);
insert into Produto values (75, 'pao de mistura', 37826, NULL);
insert into Produto values (76, 'carro hot wheels', 37827, NULL);
insert into Produto values (77, 'bola de queijo flamengo', 37828, 1325);
insert into Produto values (78, 'lixivia 1l', 37829, NULL);
insert into Produto values (79, 'pasta dos dentes oral-b', 37830, NULL);
insert into Produto values (80, 'gelado ola morango (média)', 37831, NULL);
insert into Produto values (81, 'sortido de gomas (grande)', 37834, NULL);
insert into Produto values (82, 'couve flor', 37833, 1100);

insert into CategoriaProd values (1, 'bebida');
insert into CategoriaProd values (2, 'bebidas alcoolica');
insert into CategoriaProd values (3, 'bebidas espirituosa');
insert into CategoriaProd values (4, 'refrigerante');
insert into CategoriaProd values (5, 'sumos');
insert into CategoriaProd values (6, 'agua');
insert into CategoriaProd values (7, 'aperitivo');
insert into CategoriaProd values (8, 'goluseima');
insert into CategoriaProd values (9, 'pao');
insert into CategoriaProd values (10, 'carne');
insert into CategoriaProd values (11, 'peixe');
insert into CategoriaProd values (12, 'congelado');
insert into CategoriaProd values (13, 'super bock');
insert into CategoriaProd values (14, 'fresco');
insert into CategoriaProd values (15, 'fruta');
insert into CategoriaProd values (16, 'legume');
insert into CategoriaProd values (17, 'laticineo');
insert into CategoriaProd values (18, 'brinquedo');
insert into CategoriaProd values (19, 'gelado');
insert into CategoriaProd values (20, 'yogurt');
insert into CategoriaProd values (21, 'limpeza');
insert into CategoriaProd values (22, 'higiene pessoal');
insert into CategoriaProd values (32, 'vinho');
insert into CategoriaProd values (33, 'cerveja');
insert into CategoriaProd values (34, 'azeite');
insert into CategoriaProd values (40, 'Carne de vaca');

insert into Categoria values (11, 11);
insert into Categoria values (11, 12);
insert into Categoria values (15, 11);
insert into Categoria values (15, 12);
insert into Categoria values (16, 34);
insert into Categoria values (19, 7);
insert into Categoria values (22, 16);
insert into Categoria values (36, 12);
insert into Categoria values (36, 16);
insert into Categoria values (38, 15);
insert into Categoria values (39, 13);
insert into Categoria values (40, 13);
insert into Categoria values (63, 6);
insert into Categoria values (64, 4);
insert into Categoria values (67, 32);
insert into Categoria values (68, 10);
insert into Categoria values (68, 14);
insert into Categoria values (69, 3);
insert into Categoria values (71, 3);
insert into Categoria values (72, 5);
insert into Categoria values (73, 14);
insert into Categoria values (73, 20);
insert into Categoria values (74, 9);
insert into Categoria values (75, 9);
insert into Categoria values (76, 18);
insert into Categoria values (77, 14);
insert into Categoria values (77, 17);
insert into Categoria values (78, 21);
insert into Categoria values (79, 22);
insert into Categoria values (80, 17);
insert into Categoria values (80, 19);
insert into Categoria values (81, 8);
insert into Categoria values (82, 16);
insert into Categoria values (11, 4);

insert into SubCategoria values (1, 2);
insert into SubCategoria values (2, 3);
insert into SubCategoria values (1, 4);
insert into SubCategoria values (1, 5);
insert into SubCategoria values (1, 6);
insert into SubCategoria values (2, 32);
insert into SubCategoria values (2, 33);
insert into SubCategoria values (33, 13);
insert into SubCategoria values (17, 19);
insert into SubCategoria values (17, 20);
insert into SubCategoria values (14, 15);
insert into SubCategoria values (14, 16);
insert into SubCategoria values (12, 10);
insert into SubCategoria values (12, 11);
insert into SubCategoria values (14, 10);
insert into SubCategoria values (14, 11);
insert into SubCategoria values (10, 40);

-- Lojas e Descontos
insert into CadeiaLojas values (1, 'Continente', 'www.continente.pt');
insert into CadeiaLojas values (2, 'Pingo Doce', 'www.pingodoce.pt');
insert into CadeiaLojas values (5, 'Mercadona', 'www.mercadona.pt');
insert into CadeiaLojas values (6, 'Lidl', 'www.lidl.pt');
insert into CadeiaLojas values (7, 'Aldi', 'www.aldi.pt');
insert into CadeiaLojas values (8, 'Auchan', 'www.auchan.pt');
insert into CadeiaLojas values (9, 'Makro', 'www.makro.pt');
insert into CadeiaLojas values (10, 'Pao de Acucar', 'www.paodeacucar.com');
insert into CadeiaLojas values (11, 'El Corte Ingles', 'www.elcorteingles.pt');

insert into Loja values (1, 'Mira Ramos', 'www.miraramos.com', 'Rua Herois da Patria n 967', 9, 001, NULL);
insert into Loja values (2, 'Pingo Doce Arcozelo', NULL, 'Avenida da Igreja', 9, 411, 2);
insert into Loja values (3, 'Pingo Doce Cedofeita', NULL, 'Rua da Cedofeita', 3, 175, 2);
insert into Loja values (4, 'Pingo Doce Constituição', NULL, 'Rua Monte Pedral', 3, 417, 2);
insert into Loja values (5, 'Continente Bom Dia Serpa Pinto', NULL, 'Rua de Serpa Pinto 269-271', 3, 586, 1);
insert into Loja values (6, 'Pingo Doce Santa Maria da Feira - Hiper', NULL, 'Lugar De Vila Boa', 5, 195, 2);
insert into Loja values (7, 'Continente Modelo Santa Maria da Feira', NULL, 'Rua Comendador Sa Couto', 5, 192, 1);
insert into Loja values (8, 'Mercadona', NULL, 'Rua General Norton de Matos, 480', 3, 424, 5);
insert into Loja values (9, 'Continente Colombo', NULL, 'Avenida Lusiada', 6, 392, 1);
insert into Loja values (10, 'Loja do Carlos', 'www.caca.loja.com', NULL, NULL, NULL, NULL);

insert into Desconto values (1, 10, '2019-02-01', NULL);
insert into Desconto values (2, 50, '2019-03-01', '2021-03-01');
insert into Desconto values (3, 50, '2020-04-10', '2020-06-31');
insert into Desconto values (4, 80, '2019-04-01', '2019-04-15');

insert into CategoriaDesconto values (13, 1);
insert into CategoriaDesconto values (6, 2);
insert into CategoriaDesconto values (11, 3);

insert into ProdutoDesconto values (16, 3);
insert into ProdutoDesconto values (19, 4);
insert into ProdutoDesconto values (75, 1);
insert into ProdutoDesconto values (67, 2);
insert into ProdutoDesconto values (78, 2);
insert into ProdutoDesconto values (63, 1);

insert into CadeiaDesconto values (1, 1);
insert into CadeiaDesconto values (1, 3);
insert into CadeiaDesconto values (2, 2);
insert into CadeiaDesconto values (2, 1);

insert into LojaDesconto values (1, 1);
insert into LojaDesconto values (1, 3);
insert into LojaDesconto values (2, 1);

-- Adicionar Produtos às Lojas
-- Porto
insert into InfoProduto VALUES(82, 4, 3);    -- Azeite
insert into InfoProduto VALUES(63, 4, 1);    -- Agua
insert into InfoProduto VALUES(16, 4, 3);    -- Azeite
insert into InfoProduto VALUES(38, 4, 1.29); -- Pera Rocha
insert into InfoProduto VALUES(64, 4, 1);    -- Iced Tea
insert into InfoProduto VALUES(75, 4, 0.7);  -- Pao de Mistura
insert into InfoProduto VALUES(78, 4, 6);    -- Lixivia
insert into InfoProduto VALUES(40, 5, 4);    -- Super Bock 1L
insert into InfoProduto VALUES(11, 5, 0.99); -- Carapau
insert into InfoProduto VALUES(72, 5, 0.5);  -- Compal Maracujá
insert into InfoProduto VALUES(74, 5, 0.35); -- Pão da avó
insert into InfoProduto VALUES(75, 5, 0.6);  -- Pao de Mistura
insert into InfoProduto VALUES(76, 5, 2);    -- Carro Hot'wheels
insert into InfoProduto VALUES(78, 5, 9);    -- Lixivia
insert into InfoProduto VALUES(77, 8, 2.5);  -- Bola de Quejo
insert into InfoProduto VALUES(82, 8, 1.3);  -- Couve Flor

-- Sta Maria Da Feira
insert into InfoProduto VALUES(16, 6, 2.5);    -- Azeite
insert into InfoProduto VALUES(73, 6, 0.7);    -- Iogurte Natural

-- Arcozelo
insert into InfoProduto VALUES(75, 1, 0.5);  -- Pao De Mistura
insert into InfoProduto VALUES(78, 1, 8);    -- Lixivia
insert into InfoProduto VALUES(16, 1, 3);    -- Lixivia

insert into InfoProduto VALUES(78, 2, 4.5); -- Pao de Mistura

-- Lisboa
insert into InfoProduto VALUES(63, 9, 1.2); -- Agua das Pedras
insert into InfoProduto VALUES(69, 9, 5);   -- Champanhe
insert into InfoProduto VALUES(77, 9, 3);   -- Bola de Quejo
insert into InfoProduto VALUES(81, 9, 1.5); -- Sortido de Gomas


-- Despensas
insert into Despensa VALUES(1, 'Despensa do Zé', 'Rua dos Cravinhos', 185, 6);
insert into Despensa VALUES(2, 'Despensa da família Duartina', 'Rua das Perlongas', 505, 5);
insert into Despensa VALUES(3, 'Despensa da família Carlos', 'Rua das Pedrinhas', 283, 9);
insert into Despensa VALUES(4, 'Despensa da Cantina da FEUP', 'Rua Dr. Roberto Frias', 465, 3);

-- Encher despensas
-- Zé
insert into UnidadesProduto VALUES(1, 16, 3, NULL, 0);

-- Família Duarte
insert into UnidadesProduto VALUES(2, 75, 8, 5, 1);
insert into UnidadesProduto VALUES(2, 82, 2, NULL, 0); -- TODO Min_quant a 0 ou NULL
insert into UnidadesProduto VALUES(2, 76, 10, NULL, 0);
insert into UnidadesProduto VALUES(2, 78, 2, 3, 0); -- TODO Auto renew?

-- Família Pombal
insert into UnidadesProduto VALUES(3, 73, 7, NULL, 0);
insert into UnidadesProduto VALUES(3, 74, 4, 5, 1);

-- Cantina FEUP
insert into UnidadesProduto VALUES(4, 38, 10, 5, 1);
insert into UnidadesProduto VALUES(4, 11, 50, 30, 1);
insert into UnidadesProduto VALUES(4, 15, 30, 35, 1);
insert into UnidadesProduto VALUES(4, 78, 4, NULL, 0);
insert into UnidadesProduto VALUES(4, 16, 13, 15, 1);

-- Encomendas
-- Cantina FEUP compra no Pingo Doce Constituição
insert into Encomenda VALUES(1, date('now'), 4, 4);
insert into QuantidadeProd VALUES(38, 1, NULL, 10000); -- Pera
insert into QuantidadeProd VALUES(78, 1, 200, NULL);  -- Lixivia
insert into QuantidadeProd VALUES(16, 1, 5, NULL);  -- Azeite
insert into QuantidadeProd VALUES(82, 1, NULL, 3000);  -- Couve Flor
insert into QuantidadeProd VALUES(63, 1, 7, NULL);  -- Couve Flor

insert into Encomenda VALUES(3, date('2020-05-01'), 4, 5);
insert into QuantidadeProd VALUES(11, 3, 30, NULL); -- Carapau congelado

-- Família Duarte compra no  Mira Ramos
insert into Encomenda VALUES(2, date('2020-01-15'), 2, 1);
insert into QuantidadeProd VALUES(75, 2, 8, NULL); -- Pao de mistura
insert into QuantidadeProd VALUES(78, 2, 111, NULL); -- Lixivia
