INSERT INTO dim_plano (id_plano, nt_tipo)
SELECT DISTINCT
    id_plano,
    nt_tipo
FROM stg_precificacao
WHERE id_plano IS NOT NULL
ON CONFLICT (id_plano) DO NOTHING;
