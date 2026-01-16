INSERT INTO dim_tempo (ano_mes, ano, mes)
SELECT DISTINCT
    ano_mes,
    ano_mes / 100 AS ano,
    ano_mes % 100 AS mes
FROM stg_precificacao
WHERE ano_mes IS NOT NULL
ON CONFLICT (ano_mes) DO NOTHING;
