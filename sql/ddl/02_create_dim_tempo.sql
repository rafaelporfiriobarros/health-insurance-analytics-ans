CREATE TABLE IF NOT EXISTS dim_tempo (
    id_tempo     SERIAL PRIMARY KEY,
    ano_mes      INT UNIQUE NOT NULL,
    ano          INT NOT NULL,
    mes          INT NOT NULL
);
