INSERT INTO dim_tempo (ano_mes, ano, mes)
SELECT DISTINCT
    competencia,
    competencia / 100 AS ano,
    competencia % 100 AS mes
FROM stg_igr
WHERE competencia IS NOT NULL
ON CONFLICT (ano_mes) DO NOTHING;
