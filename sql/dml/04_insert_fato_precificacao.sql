INSERT INTO fato_precificacao (
    id_plano,
    cd_faixa_etaria,
    id_tempo,
    vcm,
    pct_desp_ass,
    pct_carreg,
    pct_carreg_admin,
    pct_carreg_coml,
    pct_carreg_lucro
)
SELECT
    s.id_plano,
    s.cd_faixa_etaria,
    t.id_tempo,
    s.vcm,
    s.pct_desp_ass,
    s.pct_carreg,
    s.pct_carreg_admin,
    s.pct_carreg_coml,
    s.pct_carreg_lucro
FROM stg_precificacao s
JOIN dim_tempo t
  ON s.ano_mes = t.ano_mes;
