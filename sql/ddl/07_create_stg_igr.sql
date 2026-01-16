CREATE TABLE IF NOT EXISTS stg_igr (
    registro_ans           BIGINT,
    razao_social           TEXT,
    cobertura              TEXT,
    igr                    NUMERIC(10,2),
    qtd_reclamacoes        INT,
    qtd_beneficiarios      BIGINT,
    porte_operadora        TEXT,
    competencia            INT,
    competencia_beneficiario INT,
    dt_atualizacao         DATE,
    dt_carga               TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
