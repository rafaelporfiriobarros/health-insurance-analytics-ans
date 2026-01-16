CREATE TABLE IF NOT EXISTS fato_reclamacoes (
    id_fato             SERIAL PRIMARY KEY,
    id_operadora        BIGINT,
    id_tempo            INT,
    qtd_reclamacoes     INT,
    qtd_beneficiarios   INT,
    igr                 NUMERIC(10,2),

    CONSTRAINT fk_tempo_reclamacao
        FOREIGN KEY (id_tempo)
        REFERENCES dim_tempo (id_tempo)
);
