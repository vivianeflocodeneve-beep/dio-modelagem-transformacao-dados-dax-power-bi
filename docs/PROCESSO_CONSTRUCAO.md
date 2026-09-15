# Processo de Construção

## 1. Importação da base

A base `Financial Sample.xlsx` é carregada no Power BI e mantida como consulta de origem denominada `Financials_origem`. Essa consulta funciona como referência para as demais tabelas e pode ter o carregamento desabilitado para evitar redundância no modelo.

## 2. Tratamento inicial

São aplicadas as seguintes ações:

1. promoção da primeira linha para cabeçalhos;
2. limpeza dos campos de texto;
3. definição dos tipos de dados;
4. padronização de datas e valores numéricos.

## 3. D_Produtos

A origem é agrupada por produto. Para cada produto são calculados:

- média de unidades vendidas;
- média do preço de venda;
- mediana do preço de venda;
- maior preço de venda;
- menor preço de venda.

O campo `ID_produto` é utilizado como chave do produto e inicia em zero.

## 4. D_Produtos_Detalhes

São selecionados os campos de produto, faixa de desconto, preço de venda, unidades vendidas e preço de fabricação. A consulta recebe `ID_produto` e `ID_Produto_Detalhe` para identificação das linhas.

## 5. D_Descontos

O percentual de desconto é calculado por:

`Discount = Discounts / Gross Sales`

Após o cálculo, permanecem as combinações distintas de produto, faixa e percentual. `ID_Desconto` é utilizado como chave substituta.

## 6. D_Detalhes

São mantidas as combinações distintas de `Segment` e `Country`. Um índice cria `ID_Detalhe` e a coluna `Segment_Country` serve como informação auxiliar de conferência.

## 7. F_Vendas

A tabela fato parte da origem completa e recebe:

- `SK_ID` como chave técnica da linha;
- `ID_Produto`;
- `ID_Detalhe`, obtido por mesclagem com `D_Detalhes`;
- `ID_Desconto`, obtido por mesclagem com `D_Descontos`.

São preservadas as métricas necessárias às análises: unidades, preços, vendas brutas, descontos, vendas, COGS, lucro e data.

## 8. D_Calendario

É criada em DAX com todas as datas de 01/01/2013 a 31/12/2014 e atributos de tempo. No Power BI, deve ser marcada como tabela de datas utilizando a coluna `Date`.

## 9. Relacionamentos

Os relacionamentos principais utilizam cardinalidade 1:N, com direção de filtro da dimensão para a fato. `D_Produtos_Detalhes` é tratada como dimensão auxiliar ligada à dimensão de produtos.

## 10. Conferência

A pasta `modelo-referencia/` contém uma planilha montada a partir da mesma base com as tabelas já separadas, permitindo conferir os resultados esperados das transformações.
