-- BLOCO 01 - PERGUNTAS BÁSICAS 

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

-- BLOCO 2 — VISÃO TEMPORAL

-- 5. COMO O PREÇO MÉDIO EVOLUI AO LONGO DO TEMPO?

select t.ano, t.mes, 
	   avg(f.vcm) as preco_medio
from fato_precificacao as f
join dim_tempo as t
on f.id_tempo = t.id_tempo
group by t.ano, t.mes
order by t.ano, t.mes;

-- 6. COMO O TOTAL DE RECLAMAÇÕES EVOLUI AO LONOGO DO TEMPO ?

select t.ano, t.mes, sum(r.qtd_reclamacoes) as total_reclamacoes
from fato_reclamacoes as r
join dim_tempo as t
on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by t.ano, t.mes;

-- 7. QUAIS MESES TIVERAM MAIOR IGR MÉDIO?

select t.ano, t.mes, avg(r.igr) as igr_medio
from fato_reclamacoes as r
join dim_tempo as t 
on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by igr_medio desc;
	













