# Monitoramento de Precificação, Custos e Qualidade em Planos de Saúde

![ans](imagens/ans.jpg)


**Dados públicos da ANS | SQL - Python - BI (Looker Studio)**

## Visão Geral

Este projeto tem como objetivo **simular o ambiente analítico de uma operadora de saúde**, integrando dados reais de **precificação, estrutura de custos e qualidade percebida pelos beneficiários**, a partir de bases públicas da **ANS**.

A solução foi construída com foco em:

- **monitoramento de indicadores**

- **automação de processos de dados**

- **suporte à tomada de decisão**

## Objetivo do Projeto

**Objetivo Geral**

Desenvolver uma solução de Business Intelligence e Analytics para acompanhar, de forma mensal:

- **o valor dos planos de saúde,**

- **a composição dos custos,**

- **o índice de reclamações dos beneficiários.**

## Objetivos Específicos

- Analisar a evolução do **Valor Comercial da Mensalidade (VCM)**

- Avaliar a participação da **Despesa Assistencial** na precificação

- Monitorar o **Índice Geral de Reclamações (IGR)**

- Comparar tendências entre **Assistência Médica** e **Odontológica**

- Criar dashboards executivos com dados atualizados automaticamente

## Bases de Dados Utilizadas (Dados Reais)

### Precificação de Planos de Saúde – ANS

- Série histórica mensal (últimos 5 anos)

- Valor Comercial da Mensalidade (VCM)

- Percentual de despesa assistencial

- Percentual de carregamentos (administrativo, comercial e lucro)

- Granularidade: **Plano × Faixa Etária × Mês**

### Índice Geral de Reclamações (IGR) – ANS

- IGR por operadora

- Quantidade de reclamações

- Quantidade de beneficiários

- Tipo de cobertura (Médica / Odonto)

- Granularidade: Operadora × Cobertura × Mês

## Dicionário da tabela precificacao_ans.csv

- **ID_PLANO**: Identificação única do plano.
- **CD_NOTA**: Código de registro da nota técnica na ANS - identificação única da nota técnica.
- **NT_TIPO**: Tipo de nota técnica sendo ÚNICA ou MÚLTIPLA
- **CD_FAIXA_ETARIA**: 

    - **Faixa etária do beneficiário vinculado ao contrato**:
        - **(01)**  00 (zero) a 18 (dezoito) anos;
        - **(02)**  19 (dezenove) a 23 (vinte e três) anos;
        - **(03)**  24 (vinte e quatro) a 28 (vinte e oito) anos;
        - **(04)**  29 (vinte e nove) a 33 (trinta e três) anos;
        - **(05)**  34 (trinta e quatro) a 38 (trinta e oito) anos;
        - **(06)**  39 (trinta e nove) a 43 (quarenta e três) anos;
        - **(07)**  44 (quarenta e quatro) a 48 (quarenta e oito) anos;
        - **(08)**  49 (quarenta e nove) a 53 (cinquenta e três) anos;
        - **(09)**  54 (cinquenta e quatro) a 58 (cinquenta e oito) anos;
        - **(10)**  59 (cinquenta e nove) anos ou mais.”
    - **Nota**:  As faixas etárias da NTRP seguem o determinado pelo Art. 2º da Resolução Normativa ANS Nº 563, de 15 de dezembro de 2022.

- **ANO_MES**: Identificador do mês em que o plano estava ativo e disponível para comercialização (formato AAAAMM)
- **VCM**: Valor Comercial da Mensalidade informado na Nota Técnica do plano (Coluna T do Anexo II-B da Resolução Normativa ANS Nº 564, de 15 de dezembro de 2022)
Nota: O Valor Comercial é um valor de referência e pode apresentar diferenças em relação aos preços de comercialização praticados nas tabelas de venda utilizadas pelas operadoras. Os preços efetivamente praticados para a contratação dos produtos devem estar dentro dos limites de comercialização estabelecidos em normativo, quais sejam: 
Limite máximo: 30% acima do Valor Comercial; 
Limite mínimo: o maior valor entre o valor da despesa assistencial estimada e o limiar de 30% abaixo do Valor Comercial;
- **PCT_DESP_ASS**: Despesa assistencial é a proporção de “Despesa Assistencial Líquida por Exposto com Margem de Segurança Estatística por Exposto” (Coluna K do Anexo II-B da Resolução Normativa ANS Nº 564, de 15 de dezembro de 2022) sobre o Valor Comercial da Mensalidade.
- **PCT_CARREG**: Carregamentos referem-se às despesas não assistenciais que são adicionadas na composição do preço de venda. Tais despesas são informadas na nota técnica do plano, conforme disposto no Anexo II-B da Resolução Normativa ANS Nº 564, de 15 de dezembro de 2022. 
Carregamento Total é a soma das “Despesas de Comercialização por beneficiário” (coluna M), das “Outras Despesas da carteira de planos por beneficiáro” (coluna N), das “Despesas Administrativas por beneficiário” (coluna O) e do “Valor da Margem de Lucro por Beneficiário” (coluna R).
A métrica é expressa como proporção do Valor Comercial da Mensalidade.
- **PCT_CARREG_ADMIN**: Carregamento administrativo é a proporção de “Despesas Administrativas por Beneficiário” (coluna O do Anexo II-B da Resolução Normativa ANS Nº 564, de 15 de dezembro de 2022) sobre o Valor Comercial da Mensalidade.
- **PCT_CARREG_COML**: Carregamento comercial é a proporção de “Despesas de Comercialização por Beneficiário” (coluna M do Anexo II-B da Resolução Normativa ANS Nº 564, de 15 de dezembro de 2022) sobre o Valor Comercial da Mensalidade.
- **PCT_CARREG_LUCRO**: Carregamento de lucro é a proporção de “Valor da Margem de Lucro por Beneficiário” (coluna R do Anexo II-B da Resolução Normativa ANS Nº 564, de 15 de dezembro de 2022) sobre o Valor Comercial da Mensalidade.

## Dicionário da tabela igr_ans.csv

- **REGISTRO_ANS**: Registro de operadora de plano privado de assistência à saúde concedido pela ANS a pessoa jurídica para operação no setor de saúde suplementar. 
- **RAZAO_SOCIAL**: Razão Social da Operadora de Plano de Assistência à Saúde
- **COBERTURA**: Categorias de cobertura de produto por tipo de segmentação assistencial:
 Assistência Médica (cobertura médico-hospitalar)
 Exclusivamente odontológica
 - **IGR**: Índice Geral de Reclamação calculado para o mês de competência
 - **QTD_RECLAMACOES**: Quantidade de reclamações de beneficiários de planos de saúde apuradas na NIP (Notificação de Investigação Preliminar)
 - **QTD_BENEFICIARIOS**: Quantidade de beneficiários que tiveram reclamações registradas na ANS no mês de competência
 - **PORTE_OPERADORA**: Classificação da operadora, conforme quantidade de beneficiários com vínculo ativo no mês mais recente disponível no SIB:
    - **Grande** (acima de 100 mil  vínculos de beneficiário ativos)
    - **Médio** (de 20 mil a 100 mil vínculos de beneficiário ativos)
    - **Pequeno** (abaixo de 20 mil vínculos de beneficiário ativos)
- **COMPETENCIA**: Refere-se ao ano e mês de competência das reclamações dos beneficiários (ou seja, do numerador do IGR)
- **COMPETENCIA_BENEFICIARIO**: Refere-se ao ano e mês de competência das informações de beneficiários (ou seja, do denominador do IGR)
- **DT_ATUALIZACAO**: Data e hora da última atualização do arquivo. Os campos sem preenchimento de data indicam que a base está congelada e, portanto, não foi modificada na última atualização.


## EXPLICAÇÃO COMPLETA DO PROJETO

![diagrama](imagens/diagrama_dw.png)

### ETAPA 1 — COLETA DE DADOS (FONTES)

Foram utilizadas **duas bases oficiais da ANS:**

**1. Precificação de Planos**

- Valor Comercial da Mensalidade (VCM)

- Componentes do preço

- Faixa etária

- Série histórica mensal

**2. Índice Geral de Reclamações (IGR)**

- Reclamações registradas

- Número de beneficiários

- Porte da operadora

- Tipo de cobertura

- Série histórica mensal

### ETAPA 2 — ETL EM PYTHON (INGESTÃO)

Foram criados **dois scripts ETL:**

**etl_ingestao_precificacao.py**

Responsável por:

- Ler CSV da ANS

- Tratar encoding (UTF-8, Latin-1, BOM)

- Corrigir separador decimal brasileiro

- Converter tipos (int, float, date)

- Carregar dados em stg_precificacao

**etl_ingestao_igr.py**

Responsável por:

- Ler CSV do IGR

- Tratar inconsistência de schema

- Normalizar nomes de colunas

- Converter métricas numéricas

- Carregar dados em stg_igr

Durante o projeto, foram tratados problemas reais de produção, como:

- BOM invisível em CSV

- Encoding quebrado (MÃºltipla)

- Divergência entre schema do CSV e do banco

- Limite de parâmetros em INSERTs grandes

### ETAPA 3 — STAGING (POSTGRESQL)

As tabelas de staging armazenam os dados brutos tratados, sem regras de negócio:

- stg_precificacao

- stg_igr

Características:

- Sem chave primária

- Sem agregações

- Usadas apenas como fonte para o modelo analítico

### ETAPA 4 — MODELAGEM DIMENSIONAL (STAR SCHEMA)

Foi criado um modelo estrela, padrão em Analytics e BI.

**Dimensões**

- dim_tempo → eixo temporal mensal

- dim_plano → tipo de plano

- dim_faixa_etaria → segmentação etária

**Fatos**

- fato_precificacao → métricas de preço

- fato_reclamacoes → métricas de reclamação

A integração entre preços e reclamações ocorre via:

- dim_tempo

### ETAPA 5 — CARGA ANALÍTICA (DML)

Foram criados scripts SQL para:

- Popular dimensões com valores únicos

- Popular fatos com métricas numéricas

- Garantir integridade referencial

### ETAPA 6 — INTEGRAÇÃO PREÇO × RECLAMAÇÃO

A integração permite análises como:

- Evolução do VCM vs IGR

- Tipo de plano vs qualidade percebida

- Faixa etária vs custo e reclamação

- Base para correlação estatística

## QUERIES - PERGUNTAS DE NEGÓCIO

**1. QUANTOS REGISTROS EXISTEM EM CADA TABELA FATO?**

- R: Há **1.048.575** registros na tabela **fato_precificacao** e **146.495** registros na tabela **fato_reclamacoes**.

**2. QUAL É O PERÍODO COBERTO PELOS DADOS?**

- R: O período inicia em **01/2015** e vai até **12/2025**.

**3. QUAL É O PREÇO MÉDIO DOS PLANOS?**

- R: O preço médio dos planos é de **R$ 857.26**.

**4. QUAL É O IGR MÉDIO DO PERÍODO?**

- R: O IGR médio do período é de **111.013**.

**5. COMO O PREÇO MÉDIO EVOLUI AO LONGO DO TEMPO?**

- R: A partir de **06/2020** temos um média de (VCM) de **R$ 686.90**.
- E no final de **06/2025** temos uma média de (VCM) de **R$ 1.130.02**.

**6. COMO O TOTAL DE RECLAMAÇÕES EVOLUI AO LONOGO DO TEMPO ?**

- R: A partir de **01/2015** temos um total de **6.956** reclamações.
- E no final de **12/2025** temos um total de **22.829** reclamações.

**7. QUAIS MESES TIVERAM MAIOR IGR MÉDIO?**

- R: Os 5 primeiros meses do maior para o menor: 
    - **12/2022** com **3.056** de IGR médio.
    - **12/2021** com **1.359** de IGR médio.
    - **10/2015** com **665.22** de IGR médio.
    - **05/2019** com **415.82** de IGR médio.
    - **03/2024** com **380.56** de IGR médio.

**8. QUAL O PREÇO MÉDIO POR TIPO DE PLANO?**

- R: O plano **Mltipla** possui um preço médio de **R$ 1689.66**
- E o plano **nica** possui um preço médio de **R$ 740.34**.

**9. QUAL FAIXA ETÁRIA PAGA MAIS?**

- R: As faixas etárias **10**, **9** e **8** são as que pagam mais, ou seja, as faixas etárias de **49 anos** ou mais. 

**10. COMO O PREÇO VARIA POR FAIXA ETÁRIA AO LONGO DO TEMPO?**

- R: Ordenando as faixas etárias de **1 a 10** iniciando pelo ano de **2020 até o final em 2025** 
podemos ver que há um aumento significativo entre todas as faixas a partir de **2023**. 

**11. QUAIS PERÍODOS TIVERAM MAIS RECLAMAÇÕES?**

- R: Podemos ver que a partir do ano de **2023**, no mês de **agosto**, tiveram **35.185** reclamações, 
seguido pelo mesmo ano de **(2023)**, no mês de outubro com **34.459** reclamações. 
Em terceiro lugar veio o ano de **2024** no mês de **julho** com **33.825** reclamações.
Como vemos anteriormente que o aumento significativo dos planos iniciou-se basicamente em **2023**, 
provavelmente esse aumento de reclamações fazem todo o sentido.

**12. QUAL O IGR MÉDIO POR ANO?**

- R: De **2015** a **2025** temos um **IGR** médio de **91.85** até **105.62**. 
As maiores médias ficaram nos anos de **2022, 2021, 2024 e 2019**.

**13. QUANDO O PREÇO MÉDIO SOBE, O IGR SOBE OU DESCE?**

- R: Não sobe constantemente, podemos ver que o **preço médio** de **2020** 
até **2025** foi de **R$ 700** até **R$ 1.114**. O **IGR** médio foi de **72.62** em **2020**, **176.73** em **2021**, **352.09** em **2022**, e depois caiu para **84.92** em **2023** com um aumento de preço médio de **R$ 779.70** em 2022 para **R$ 907.84** em **2023**, então não seguiu um aumento constante conforme o aumento do preço médio dos planos.













## Stack Tecnológico

- **Banco de Dados:** PostgreSQL

- **ETL:** SQL + Python (pandas, psycopg2)

- **Modelagem:** Star Schema

- **Visualização:** Looker Studio




