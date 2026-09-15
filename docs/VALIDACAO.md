# Validação da Entrega

## Arquivo-fonte

- Base: `Financial Sample.xlsx`
- Registros: **700**
- Campos: **16**
- Produtos: **6**
- Segmentos: **5**
- Países: **5**
- Faixas de desconto: **4**
- Menor data de venda: **01/01/2013**
- Maior data de venda: **01/12/2014**

## Planilha dimensional de referência

A planilha `Modelo_Dimensional_Referencia.xlsx` foi gerada diretamente a partir da base utilizada e contém:

| Tabela | Quantidade de registros |
|---|---:|
| `Financials_origem` | 700 |
| `D_Produtos` | 6 |
| `D_Produtos_Detalhes` | 700 |
| `D_Descontos` | 24 |
| `D_Detalhes` | 25 |
| `D_Calendario` | 730 |
| `F_Vendas` | 700 |

A verificação programática da planilha não identificou erros de célula do tipo `#REF!`, `#DIV/0!`, `#VALUE!`, `#NAME?` ou `#N/A`.

## Arquivo PBIX

O arquivo `Modelagem_DAX_PowerBI_Viviane_Rambor.pbix` foi validado estruturalmente como pacote Power BI. O teste de integridade do contêiner não apontou entradas corrompidas e foram encontrados os componentes internos esperados, incluindo `DataModel`, `Report/Layout`, `Metadata`, `DiagramLayout` e tema do relatório.

O `DiagramLayout` contém os seis nós do modelo:

- `D_Calendario`;
- `D_Descontos`;
- `D_Detalhes`;
- `D_Produtos`;
- `D_Produtos_Detalhes`;
- `F_Vendas`.

A validação realizada neste ambiente é estrutural. A abertura final no Power BI Desktop é recomendada antes da publicação para confirmar a compatibilidade da versão local do aplicativo e, se necessário, atualizar o caminho da fonte Excel.

## Integridade

O arquivo `CHECKSUMS.txt` registra os hashes SHA-256 dos principais artefatos da entrega.
