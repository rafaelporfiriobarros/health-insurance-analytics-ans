CREATE TABLE IF NOT EXISTS stg_precificacao (
    id_plano               BIGINT,
    cd_nota                BIGINT,
    nt_tipo                TEXT,
    cd_faixa_etaria        INT,
    ano_mes                INT,
    vcm                    NUMERIC(10,2),
    pct_desp_ass            NUMERIC(6,2),
    pct_carreg              NUMERIC(6,2),
    pct_carreg_admin        NUMERIC(6,2),
    pct_carreg_coml         NUMERIC(6,2),
    pct_carreg_lucro        NUMERIC(6,2),
    dt_carga                TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
