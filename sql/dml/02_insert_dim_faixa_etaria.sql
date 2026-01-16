INSERT INTO dim_faixa_etaria (cd_faixa_etaria, descricao)
SELECT DISTINCT
    cd_faixa_etaria,
    CONCAT('Faixa ', cd_faixa_etaria)
FROM stg_precificacao
WHERE cd_faixa_etaria IS NOT NULL
ON CONFLICT (cd_faixa_etaria) DO NOTHING;
