let
    Fonte = Financials_origem,
    Selecionadas = Table.SelectColumns(Fonte, {"Product", "Discount Band", "Sale Price", "Units Sold", "Manufacturing Price"}),
    IDProduto = Table.AddColumn(Selecionadas, "ID_produto", each if [Product] = "Carretera" then 0
        else if [Product] = "Montana" then 1
        else if [Product] = "Paseo" then 2
        else if [Product] = "Velo" then 3
        else if [Product] = "VTT" then 4
        else if [Product] = "Amarilla" then 5
        else null, Int64.Type),
    Distintas = Table.Distinct(IDProduto),
    IDDetalheProduto = Table.AddIndexColumn(Distintas, "ID_Produto_Detalhe", 1, 1, Int64.Type),
    Reordenado = Table.ReorderColumns(
        IDDetalheProduto,
        {"ID_Produto_Detalhe", "ID_produto", "Product", "Discount Band", "Sale Price", "Units Sold", "Manufacturing Price"}
    )
in
    Reordenado
