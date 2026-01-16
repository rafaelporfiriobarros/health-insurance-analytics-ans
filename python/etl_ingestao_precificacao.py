import os
from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from dotenv import load_dotenv

# =========================================================
# Configuração de ambiente
# =========================================================
BASE_DIR = Path(__file__).resolve().parent.parent
load_dotenv(BASE_DIR / ".env", override=True)

DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_PORT = int(os.getenv("DB_PORT", 5432))

if not all([DB_HOST, DB_NAME, DB_USER, DB_PASSWORD]):
    raise ValueError("Variáveis de ambiente do banco não configuradas corretamente.")

# =========================================================
# Leitura do CSV (ANS)
# =========================================================
csv_path = BASE_DIR / "data" / "raw" / "precificacao_ans.csv"
if not csv_path.exists():
    raise FileNotFoundError(f"Arquivo não encontrado: {csv_path}")

df = pd.read_csv(
    csv_path,
    sep=";",
    encoding="utf-8-sig",  # remove BOM automaticamente
    dtype=str
)


# Padronizar nomes das colunas
df.columns = (
    df.columns
      .str.strip()
      .str.lower()
      .str.replace(" ", "_")
)

print(df.columns.tolist())

# =========================================================
# Tratamento de dados
# =========================================================

# Texto (encoding)
df["nt_tipo"] = (
    df["nt_tipo"]
    .str.encode("latin1")
    .str.decode("utf-8", errors="ignore")
)

# Numéricos com separador brasileiro
float_cols = [
    "vcm",
    "pct_desp_ass",
    "pct_carreg",
    "pct_carreg_admin",
    "pct_carreg_coml",
    "pct_carreg_lucro"
]

df[float_cols] = (
    df[float_cols]
      .apply(lambda s: s.str.replace(",", ".", regex=False))
      .apply(pd.to_numeric, errors="coerce")
)

# Inteiros
int_cols = ["id_plano", "cd_nota", "cd_faixa_etaria", "ano_mes"]
df[int_cols] = df[int_cols].apply(pd.to_numeric, errors="coerce").astype("Int64")

# =========================================================
# Carga no PostgreSQL
# =========================================================
engine = create_engine(
    URL.create(
        "postgresql+psycopg2",
        username=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
    )
)

with engine.begin() as conn:
    df.to_sql(
        "stg_precificacao",
        con=conn,
        if_exists="append",
        index=False,
        method="multi",
        chunksize=10_000
    )

print("ETL de precificação concluído com sucesso.")
