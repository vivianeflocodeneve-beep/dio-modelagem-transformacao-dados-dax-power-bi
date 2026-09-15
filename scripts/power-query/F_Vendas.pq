let
    Fonte = Financials_origem,
    SK = Table.AddIndexColumn(Fonte, "SK_ID", 1, 1, Int64.Type),
    IDProduto = Table.AddColumn(SK, "ID_Produto", each if [Product] = "Carretera" then 0
        else if [Product] = "Montana" then 1
        else if [Product] = "Paseo" then 2
        else if [Product] = "Velo" then 3
        else if [Product] = "VTT" then 4
        else if [Product] = "Amarilla" then 5
        else null, Int64.Type),
    PercentualDesconto = Table.AddColumn(
        IDProduto,
        "Discount",
        each if [Gross Sales] = null or [Gross Sales] = 0 then 0 else Number.Round([Discounts] / [Gross Sales], 6),
        type number
    ),
    MesclaDetalhes = Table.NestedJoin(
        PercentualDesconto,
        {"Segment", "Country"},
        D_Detalhes,
        {"Segment", "Country"},
        "DimDetalhes",
        JoinKind.LeftOuter
    ),
    ExpandeDetalhes = Table.ExpandTableColumn(MesclaDetalhes, "DimDetalhes", {"ID_Detalhe"}, {"ID_Detalhe"}),
    MesclaDescontos = Table.NestedJoin(
        ExpandeDetalhes,
        {"ID_Produto", "Discount Band", "Discount"},
        D_Descontos,
        {"ID_produto", "Discount Band", "Discount"},
        "DimDescontos",
        JoinKind.LeftOuter
    ),
    ExpandeDescontos = Table.ExpandTableColumn(MesclaDescontos, "DimDescontos", {"ID_Desconto"}, {"ID_Desconto"}),
    ColunasFato = Table.SelectColumns(
        ExpandeDescontos,
        {"SK_ID", "ID_Produto", "ID_Detalhe", "ID_Desconto", "Product", "Units Sold",
         "Manufacturing Price", "Sale Price", "Discount Band", "Segment", "Country",
         "Gross Sales", "Discounts", "Sales", "COGS", "Profit", "Date"}
    )
in
    ColunasFato
