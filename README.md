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

## EXPLICAÇÃO COMPLETA DO PROJETO

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

## Stack Tecnológico

- **Banco de Dados:** PostgreSQL

- **ETL:** SQL + Python (pandas, psycopg2)

- **Modelagem:** Star Schema

- **Visualização:** Looker Studio




