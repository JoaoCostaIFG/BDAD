# iPantry

Pretedemos simular um sistema centralizado que permita vários utilizadores manter
um inventário atualizado de todos os produtos que têm nas suas despensas.

Cada despensa (uma despensa representa um cliente) tem nome, morada e os produtos
em inventário. Para cada um destes produto é registada a quantidade atualmente guardada.
Cada utilizador pode caracterizar certos produtos e/ou categorias/sub-categorias
de produtos como 'vitais', isto é, produtos e/ou categorias de produtos que o cliente
quer manter sempre disponível em stock. Para este efeito, o utilizador define uma
quantidade mínima a manter em stock antes de ser alertado.

Sobre cada produto é guardado o nome, o código de barras (se existir), as lojas onde
pode ser comprado e o respetivo preço em cada uma dessas. Cada loja tem nome e morada.
Uma cadeia de lojas é uma agregação de diversas lojas e tem um nome e uma lista de
descontos associada a diversos produtos. Uma loja pode (no máximo) fazer parte de
uma cadeia de lojas. Caso não faça parte de um cadeia de lojas, uma loja pode ter
a sua própria lista de descontos a aplicar aos seus produtos.

Cada produto tem de pertencer a pelo menos uma categoria (TipoProduto). As categorias
serão hierarquizadas (ex.: Bebida -> Refrigerante, Sumo, Bebidas Alcoolicas;
Bebidas Alcoolicas -> Vinho, Cerveja, Bebidas Espírituosas).

O utilizador pode listar o conteúdo da sua dispensa, filtrar/procurar produtos por
categoria e/ou nome e realizar encomendas (em lojas que o permitam) tanto automáticas
(caso de produtos 'vitais') como espontâneas, por exemplo, uma lista de compras que
tenta comprar os produtos nas lojas que o tenham em stock a menor preço.

Ao ter um histórico das compras de cada utilizador será possível sugerir produtos
recomendados.
