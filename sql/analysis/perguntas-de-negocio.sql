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

-- 8. Qual o preço médio por tipo de plano?

SELECT
    p.nt_tipo,
    AVG(f.vcm) AS preco_medio
FROM fato_precificacao f
JOIN dim_plano p ON f.id_plano = p.id_plano
GROUP BY p.nt_tipo
ORDER BY preco_medio DESC;

-- 9. Qual faixa etária paga mais?

select f.cd_faixa_etaria, avg(f.vcm) as preco_medio
from fato_precificacao as f
group by f.cd_faixa_etaria
order by preco_medio desc;

-- 10. Como o preço varia por faixa etária ao longo do tempo?

select t.ano, f.cd_faixa_etaria, avg(f.vcm) as preco_medio
from fato_precificacao as f
join dim_tempo as t
on f.id_tempo = t.id_tempo
group by t.ano, f.cd_faixa_etaria
order by t.ano, f.cd_faixa_etaria;

-- 11. Quais períodos tiveram mais reclamações? 

select t.ano, t.mes, sum(r.qtd_reclamacoes) as total_reclamacoes
from fato_reclamacoes as r
join dim_tempo as t
on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by total_reclamacoes desc;


-- 12. QUAL O IGR MÉDIO POR ANO?

select t.ano, avg(r.igr) as igr_medio
from fato_reclamacoes as r
join dim_tempo as t
on r.id_tempo = t.id_tempo
group by t.ano
order by t.ano;

-- 13. Quando o preço médio sobe, o IGR sobe ou desce?

select t.ano, avg(p.vcm) as preco_medio, avg(r.igr) as igr_medio
from fato_precificacao as p
join fato_reclamacoes as r
on p.id_tempo = r.id_tempo
join dim_tempo as t 
on p.id_tempo = t.id_tempo
group by t.ano
order by t.ano;


-

	