let
    Fonte = Financials_origem,
    Selecionadas = Table.SelectColumns(Fonte, {"Segment", "Country"}),
    Distintas = Table.Distinct(Selecionadas),
    Ordenadas = Table.Sort(Distintas, {{"Segment", Order.Ascending}, {"Country", Order.Ascending}}),
    IDDetalhe = Table.AddIndexColumn(Ordenadas, "ID_Detalhe", 1, 1, Int64.Type),
    ChaveTexto = Table.AddColumn(IDDetalhe, "Segment_Country", each [Segment] & " | " & [Country], type text),
    Reordenado = Table.ReorderColumns(ChaveTexto, {"ID_Detalhe", "Segment", "Country", "Segment_Country"})
in
    Reordenado
