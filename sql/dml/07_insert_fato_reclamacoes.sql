INSERT INTO fato_reclamacoes (
    id_operadora,
    id_tempo,
    qtd_reclamacoes,
    qtd_beneficiarios,
    igr
)
SELECT
    s.registro_ans       AS id_operadora,
    t.id_tempo,
    s.qtd_reclamacoes,
    s.qtd_beneficiarios,
    s.igr
FROM stg_igr s
JOIN dim_tempo t
  ON s.competencia = t.ano_mes
WHERE s.competencia IS NOT NULL;
