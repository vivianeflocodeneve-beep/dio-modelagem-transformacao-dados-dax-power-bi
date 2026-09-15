let
    CaminhoArquivo = "C:\SEU_CAMINHO\Financial Sample.xlsx",
    Fonte = Excel.Workbook(File.Contents(CaminhoArquivo), null, true),
    Financials = Fonte{[Item="Financials", Kind="Sheet"]}[Data],
    CabecalhosPromovidos = Table.PromoteHeaders(Financials, [PromoteAllScalars=true]),
    TextosLimpos = Table.TransformColumns(
        CabecalhosPromovidos,
        {
            {"Segment", each Text.Trim(Text.From(_)), type text},
            {"Country", each Text.Trim(Text.From(_)), type text},
            {"Product", each Text.Trim(Text.From(_)), type text},
            {"Discount Band", each Text.Trim(Text.From(_)), type text},
            {"Month Name", each Text.Trim(Text.From(_)), type text}
        }
    ),
    TiposAlterados = Table.TransformColumnTypes(
        TextosLimpos,
        {
            {"Segment", type text}, {"Country", type text}, {"Product", type text},
            {"Discount Band", type text}, {"Units Sold", type number},
            {"Manufacturing Price", Currency.Type}, {"Sale Price", Currency.Type},
            {"Gross Sales", Currency.Type}, {"Discounts", Currency.Type},
            {"Sales", Currency.Type}, {"COGS", Currency.Type}, {"Profit", Currency.Type},
            {"Date", type date}, {"Month Number", Int64.Type}, {"Month Name", type text},
            {"Year", Int64.Type}
        }
    )
in
    TiposAlterados
