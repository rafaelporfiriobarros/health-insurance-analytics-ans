select * from fato_precificacao limit 10;

select * from fato_reclamacoes limit 10;

select count(*) from fato_reclamacoes;

select count(*) from fato_precificacao;

select * from fato_reclamacoes where igr > 100;

select id_tempo, vcm
from fato_precificacao
order by vcm desc 
limit 10;

select id_tempo, avg(vcm) as vcm_medio
from fato_precificacao
group by id_tempo;

select id_tempo, sum(qtd_reclamacoes) as total_reclamacoes
from fato_reclamacoes
group by id_tempo;

select id_tempo, sum(qtd_reclamacoes) as total_reclamacoes
from fato_reclamacoes
group by id_tempo
having sum(qtd_reclamacoes) > 100;

select t.ano, t.mes, avg(f.vcm) as vcm_medio
from fato_precificacao as f
join dim_tempo as t
on f.id_tempo = t.id_tempo
group by t.ano, t.mes
order by t.ano, t.mes;

select p.nt_tipo, avg(f.vcm) as vcm_medio
from fato_precificacao as f
join dim_plano as p
on f.id_plano = p.id_plano
group by p.nt_tipo;

select t.ano, avg(p.vcm) as vcm_medio, 
              avg(r.igr) as igr_medio
from fato_precificacao as p
join fato_reclamacoes as r
on p.id_tempo = r.id_tempo
join dim_tempo as t
on p.id_tempo = t.id_tempo
group by t.ano;



-- QUANTOS REGISTROS EXISTEM EM CADA TABELA FATO?

select 'fato_precificacao' as tabela, count(*) from fato_precificacao
union all
select 'fato_reclamacoes', count(*) from fato_reclamacoes;

-- QUAL É O PERÍODO COBERTO PELOS DADOS?

select min(ano_mes) as inicio,
	   max(ano_mes) as fim
from dim_tempo;

-- QUAL É O PREÇO MÉDIO DOS PLANOS?

select avg(vcm) AS preco_medio
from fato_precificacao;

-- QUAL É O IGR MÉDIO DO PERÍODO?

select avg(igr) as igr_medio
from fato_reclamacoes;

-- COMO O PREÇO MÉDIO EVOLUI AO LONGO DO TEMPO?

select t.ano, t.mes, 
	   avg(f.vcm) as preco_medio
from fato_precificacao as f
join dim_tempo as t
on f.id_tempo = t.id_tempo
group by t.ano, t.mes
order by t.ano, t.mes;

-- COMO O TOTAL DE RECLAMAÇÕES EVOLUI AO LONOGO DO TEMPO ?

select t.ano, t.mes, sum(r.qtd_reclamacoes) as total_reclamacoes
from fato_reclamacoes as r
join dim_tempo as t
on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by t.ano, t.mes;

-- QUAIS MESES TIVERAM MAIOR IGR MÉDIO?

select t.ano, t.mes, avg(r.igr) as igr_medio
from fato_reclamacoes as r
join dim_tempo as t 
on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by igr_medio desc;

-- Qual o preço médio por tipo de plano?

select
    p.nt_tipo,
    AVG(f.vcm) as preco_medio
from fato_precificacao f
join dim_plano p on f.id_plano = p.id_plano
group by p.nt_tipo
order by preco_medio desc;

-- Qual faixa etária paga mais?

select f.cd_faixa_etaria, avg(f.vcm) as preco_medio
from fato_precificacao as f
group by f.cd_faixa_etaria
order by preco_medio desc;

--  Como o preço varia por faixa etária ao longo do tempo?

select t.ano, f.cd_faixa_etaria, avg(f.vcm) as preco_medio
from fato_precificacao as f
join dim_tempo as t
on f.id_tempo = t.id_tempo
group by t.ano, f.cd_faixa_etaria
order by t.ano, f.cd_faixa_etaria;

--  Quais períodos tiveram mais reclamações? 

select t.ano, t.mes, sum(r.qtd_reclamacoes) as total_reclamacoes
from fato_reclamacoes as r
join dim_tempo as t
on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by total_reclamacoes desc;


--  QUAL O IGR MÉDIO POR ANO?

select t.ano, avg(r.igr) as igr_medio
from fato_reclamacoes as r
join dim_tempo as t
on r.id_tempo = t.id_tempo
group by t.ano
order by t.ano;

--  Quando o preço médio sobe, o IGR sobe ou desce?

select t.ano, avg(p.vcm) as preco_medio, avg(r.igr) as igr_medio
from fato_precificacao as p
join fato_reclamacoes as r
on p.id_tempo = r.id_tempo
join dim_tempo as t 
on p.id_tempo = t.id_tempo
group by t.ano
order by preco_medio;


--  Meses caros têm mais ou menos reclamações?

select
    t.ano,
    t.mes,
    AVG(p.vcm) as preco_medio,
    SUM(r.qtd_reclamacoes) as total_reclamacoes
from fato_precificacao p
join fato_reclamacoes r on p.id_tempo = r.id_tempo
join dim_tempo t on p.id_tempo = t.id_tempo
group by t.ano, t.mes
order by preco_medio desc;

--  Qual foi a variação do preço ano a ano? 

select t.ano, avg(f.vcm) as preco_medio, 
       lag(avg(f.vcm)) over(order by t.ano) as preco_ano_anterior
from fato_precificacao as f
join dim_tempo as t 
on f.id_tempo = t.id_tempo
group by t.ano;

--  Existe diferença entre o aumento de preço e reclamações?

select
    t.ano,
    avg(p.vcm) as preco_medio,
    LAG(avg(r.igr)) over (order by t.ano) as igr_ano_anterior
from fato_precificacao p
join fato_reclamacoes r on p.id_tempo = r.id_tempo
join dim_tempo t on p.id_tempo = t.id_tempo
group by t.ano;





	