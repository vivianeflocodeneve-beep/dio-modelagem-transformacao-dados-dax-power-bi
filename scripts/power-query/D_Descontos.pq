let
    Fonte = Financials_origem,
    Selecionadas = Table.SelectColumns(Fonte, {"Product", "Discount Band", "Discounts", "Gross Sales"}),
    IDProduto = Table.AddColumn(Selecionadas, "ID_produto", each if [Product] = "Carretera" then 0
        else if [Product] = "Montana" then 1
        else if [Product] = "Paseo" then 2
        else if [Product] = "Velo" then 3
        else if [Product] = "VTT" then 4
        else if [Product] = "Amarilla" then 5
        else null, Int64.Type),
    Percentual = Table.AddColumn(
        IDProduto,
        "Discount",
        each if [Gross Sales] = null or [Gross Sales] = 0 then 0 else Number.Round([Discounts] / [Gross Sales], 6),
        type number
    ),
    Mantidas = Table.SelectColumns(Percentual, {"ID_produto", "Product", "Discount Band", "Discount"}),
    Distintas = Table.Distinct(Mantidas),
    Ordenadas = Table.Sort(Distintas, {{"ID_produto", Order.Ascending}, {"Discount Band", Order.Ascending}, {"Discount", Order.Ascending}}),
    IDDesconto = Table.AddIndexColumn(Ordenadas, "ID_Desconto", 1, 1, Int64.Type),
    Reordenado = Table.ReorderColumns(IDDesconto, {"ID_Desconto", "ID_produto", "Product", "Discount Band", "Discount"})
in
    Reordenado
