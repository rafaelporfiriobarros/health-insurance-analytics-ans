CREATE TABLE IF NOT EXISTS fato_precificacao (
    id_fato                SERIAL PRIMARY KEY,

    id_plano               BIGINT NOT NULL,
    cd_faixa_etaria        INT NOT NULL,
    id_tempo               INT NOT NULL,

    vcm                    NUMERIC(10,2),
    pct_desp_ass            NUMERIC(6,2),
    pct_carreg              NUMERIC(6,2),
    pct_carreg_admin        NUMERIC(6,2),
    pct_carreg_coml         NUMERIC(6,2),
    pct_carreg_lucro        NUMERIC(6,2),

    CONSTRAINT fk_plano
        FOREIGN KEY (id_plano)
        REFERENCES dim_plano (id_plano),

    CONSTRAINT fk_faixa_etaria
        FOREIGN KEY (cd_faixa_etaria)
        REFERENCES dim_faixa_etaria (cd_faixa_etaria),

    CONSTRAINT fk_tempo
        FOREIGN KEY (id_tempo)
        REFERENCES dim_tempo (id_tempo)
);
