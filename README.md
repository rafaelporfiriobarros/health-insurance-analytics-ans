# Monitoramento de Precificação, Custos e Qualidade em Planos de Saúde

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

## Modelagem de Dados

O projeto utiliza um **modelo estrela (Star Schema)**, com **duas tabelas fato independentes**, respeitando as diferentes granularidades das bases.

**Tabelas Fato**

- fato_precificacao

- fato_igr

**Tabelas Dimensão**

- dim_tempo

- dim_operadora

- dim_plano

- dim_faixa_etaria

- dim_cobertura

A integração ocorre **via dimensões compartilhadas**, evitando associações indevidas entre planos e reclamações.

## Stack Tecnológico

- **Banco de Dados:** PostgreSQL

- **ETL:** SQL + Python (pandas, psycopg2)

- **Modelagem:** Star Schema

- **Visualização:** Looker Studio




