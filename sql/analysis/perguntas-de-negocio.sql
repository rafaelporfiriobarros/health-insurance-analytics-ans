-- quantos registros existem em cada tabela fato?

select 'fato_precificacao' as tabela, count(*) from fato_precificacao
union all
select 'fato_reclamacoes', count(*) from fato_reclamacoes;

-- qual é o período coberto pelos dados?

select min(ano_mes) as inicio,
       max(ano_mes) as fim
from dim_tempo;

-- qual é o preço médio dos planos?

select avg(vcm) as preco_medio
from fato_precificacao;

-- qual é o igr médio do período?

select avg(igr) as igr_medio
from fato_reclamacoes;

-- como o preço médio evolui ao longo do tempo?

select t.ano, t.mes,
       avg(f.vcm) as preco_medio
from fato_precificacao as f
join dim_tempo as t
  on f.id_tempo = t.id_tempo
group by t.ano, t.mes
order by t.ano, t.mes;

-- como o total de reclamações evolui ao lonogo do tempo?

select t.ano, t.mes, sum(r.qtd_reclamacoes) as total_reclamacoes
from fato_reclamacoes as r
join dim_tempo as t
  on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by t.ano, t.mes;

-- quais meses tiveram maior igr médio?

select t.ano, t.mes, avg(r.igr) as igr_medio
from fato_reclamacoes as r
join dim_tempo as t
  on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by igr_medio desc;

-- qual o preço médio por tipo de plano?

select
    p.nt_tipo,
    avg(f.vcm) as preco_medio
from fato_precificacao f
join dim_plano p
  on f.id_plano = p.id_plano
group by p.nt_tipo
order by preco_medio desc;

-- qual faixa etária paga mais?

select f.cd_faixa_etaria, avg(f.vcm) as preco_medio
from fato_precificacao as f
group by f.cd_faixa_etaria
order by preco_medio desc;

-- como o preço varia por faixa etária ao longo do tempo?

select t.ano, f.cd_faixa_etaria, avg(f.vcm) as preco_medio
from fato_precificacao as f
join dim_tempo as t
  on f.id_tempo = t.id_tempo
group by t.ano, f.cd_faixa_etaria
order by t.ano, f.cd_faixa_etaria;

-- quais períodos tiveram mais reclamações?

select t.ano, t.mes, sum(r.qtd_reclamacoes) as total_reclamacoes
from fato_reclamacoes as r
join dim_tempo as t
  on r.id_tempo = t.id_tempo
group by t.ano, t.mes
order by total_reclamacoes desc;

-- qual o igr médio por ano?

select t.ano, avg(r.igr) as igr_medio
from fato_reclamacoes as r
join dim_tempo as t
  on r.id_tempo = t.id_tempo
group by t.ano
order by t.ano;

-- quando o preço médio sobe, o igr sobe ou desce?

select t.ano, avg(p.vcm) as preco_medio, avg(r.igr) as igr_medio
from fato_precificacao as p
join fato_reclamacoes as r
  on p.id_tempo = r.id_tempo
join dim_tempo as t
  on p.id_tempo = t.id_tempo
group by t.ano
order by preco_medio;

-- meses caros têm mais ou menos reclamações?

select
    t.ano,
    t.mes,
    avg(p.vcm) as preco_medio,
    sum(r.qtd_reclamacoes) as total_reclamacoes
from fato_precificacao p
join fato_reclamacoes r
  on p.id_tempo = r.id_tempo
join dim_tempo t
  on p.id_tempo = t.id_tempo
group by t.ano, t.mes
order by preco_medio desc;

-- qual foi a variação do preço ano a ano?

select t.ano,
       avg(f.vcm) as preco_medio,
       lag(avg(f.vcm)) over (order by t.ano) as preco_ano_anterior
from fato_precificacao as f
join dim_tempo as t
  on f.id_tempo = t.id_tempo
group by t.ano;

-- existe diferença entre o aumento de preço e reclamações?

select
    t.ano,
    avg(p.vcm) as preco_medio,
    lag(avg(r.igr)) over (order by t.ano) as igr_ano_anterior
from fato_precificacao p
join fato_reclamacoes r
  on p.id_tempo = r.id_tempo
join dim_tempo t
  on p.id_tempo = t.id_tempo
group by t.ano;

-- aumentos de preço estão sendo seguidos por aumento de reclamações? (usando with)

with precificacao as (
    select id_tempo, avg(vcm) as vcm_medio
    from fato_precificacao
    group by id_tempo
),
reclamacoes as (
    select id_tempo, avg(igr) as igr_medio
    from fato_reclamacoes
    group by id_tempo
)
select t.ano,
       t.mes,
       p.vcm_medio,
       r.igr_medio,
       r.igr_medio - lag(r.igr_medio) over (order by t.ano, t.mes) as delta_igr,
       p.vcm_medio - lag(p.vcm_medio) over (order by t.ano, t.mes) as delta_vcm
from precificacao as p
join reclamacoes as r
  on p.id_tempo = r.id_tempo
join dim_tempo as t
  on t.id_tempo = p.id_tempo
order by t.ano, t.mes;

-- quais meses tiveram reclamações fora do padrão histórico?

with mensal as (
    select
        t.ano,
        t.mes,
        sum(r.qtd_reclamacoes) as total_reclamacoes
    from fato_reclamacoes r
    join dim_tempo t
      on r.id_tempo = t.id_tempo
    group by t.ano, t.mes
),
stats as (
    select
        avg(total_reclamacoes) as media,
        stddev(total_reclamacoes) as desvio
    from mensal
)
select
    m.ano,
    m.mes,
    m.total_reclamacoes,
    (m.total_reclamacoes - s.media) / s.desvio as z_score
from mensal m
cross join stats s
where abs((m.total_reclamacoes - s.media) / s.desvio) > 2
order by z_score desc;

-- quais faixas etárias apresentam maior exposição financeira dado um nível médio de reclamação?

select f.cd_faixa_etaria,
       avg(f.vcm) as vcm_medio,
       avg(r.igr) as igr_medio
from fato_precificacao as f
join fato_reclamacoes as r
  on f.id_tempo = r.id_tempo
group by f.cd_faixa_etaria
having avg(r.igr) > (select avg(igr) from fato_reclamacoes)
order by igr_medio desc;

-- reajustes geraram aumento proporcional de receita sem piorar experiência?

with base as (
    select
        p.id_tempo,
        avg(p.vcm) as vcm_medio,
        avg(r.igr) as igr_medio
    from fato_precificacao p
    join fato_reclamacoes r
      on p.id_tempo = r.id_tempo
    group by p.id_tempo
),
anual as (
    select
        t.ano,
        avg(b.vcm_medio) as vcm_medio,
        avg(b.igr_medio) as igr_medio
    from base b
    join dim_tempo t
      on b.id_tempo = t.id_tempo
    group by t.ano
),
comparacao as (
    select
        ano,
        vcm_medio,
        igr_medio,
        lag(vcm_medio) over (order by ano) as vcm_anterior,
        lag(igr_medio) over (order by ano) as igr_anterior
    from anual
)
select
    ano,
    vcm_medio,
    igr_medio,
    vcm_anterior,
    igr_anterior
from comparacao
where vcm_medio > vcm_anterior
  and igr_medio <= igr_anterior;


-- Qual seria o impacto de um reajuste médio de +5% no VCM?

select
    t.ano,
    avg(vcm) as vcm_atual,
    avg(vcm * 1.05) as vcm_simulado
from fato_precificacao f
join dim_tempo t
  on f.id_tempo = t.id_tempo
group by t.ano;
