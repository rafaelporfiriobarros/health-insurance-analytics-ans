-- BLOCO 01 

-- 1. QUANTOS REGISTROS EXISTEM EM CADA TABELA FATO?

select 'fato_precificacao' as tabela, count(*) from fato_precificacao
union all
select 'fato_reclamacoes', count(*) from fato_reclamacoes;

-- 2. QUAL É O PERÍODO COBERTO PELOS DADOS?

select min(ano_mes) as inicio,
	   max(ano_mes) as fim
from dim_tempo;

-- 3. QUAL É O PREÇO MÉDIO DOS PLANOS?

select avg(vcm) AS preco_medio
from fato_precificacao;

-- 4. QUAL É O IGR MÉDIO DO PERÍODO?

select avg(igr) as igr_medio
from fato_reclamacoes;


