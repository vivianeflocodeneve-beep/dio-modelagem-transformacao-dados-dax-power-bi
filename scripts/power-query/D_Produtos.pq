let
    Fonte = Financials_origem,
    Agrupado = Table.Group(
        Fonte,
        {"Product"},
        {
            {"Média de Unidades Vendidas", each List.Average([Units Sold]), type number},
            {"Média do valor de vendas", each List.Average([Sale Price]), type number},
            {"Mediana do valor de vendas", each List.Median([Sale Price]), type number},
            {"Valor máximo de Venda", each List.Max([Sale Price]), type number},
            {"Valor mínimo de Venda", each List.Min([Sale Price]), type number}
        }
    ),
    IDProduto = Table.AddColumn(Agrupado, "ID_produto", each if [Product] = "Carretera" then 0
        else if [Product] = "Montana" then 1
        else if [Product] = "Paseo" then 2
        else if [Product] = "Velo" then 3
        else if [Product] = "VTT" then 4
        else if [Product] = "Amarilla" then 5
        else null, Int64.Type),
    Reordenado = Table.ReorderColumns(
        IDProduto,
        {"ID_produto", "Product", "Média de Unidades Vendidas", "Média do valor de vendas",
         "Mediana do valor de vendas", "Valor máximo de Venda", "Valor mínimo de Venda"}
    ),
    Renomeado = Table.RenameColumns(Reordenado, {{"Product", "Produto"}})
in
    Renomeado
