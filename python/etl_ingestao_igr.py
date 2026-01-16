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
    raise ValueError("Variáveis de ambiente não configuradas corretamente.")

# =========================================================
# Leitura do CSV IGR (ANS)
# =========================================================
csv_path = BASE_DIR / "data" / "raw" / "igr_ans.csv"
if not csv_path.exists():
    raise FileNotFoundError(f"Arquivo não encontrado: {csv_path}")

df = pd.read_csv(
    csv_path,
    sep=";",
    encoding="utf-8-sig",
    dtype=str
)

# =========================================================
# Padronizar colunas
# =========================================================
df.columns = (
    df.columns
      .str.strip()
      .str.lower()
      .str.replace(" ", "_")
)

# =========================================================
# Tratamento de dados
# =========================================================

# Texto
for col in ["razao_social", "cobertura", "porte_operadora"]:
    df[col] = (
        df[col]
        .str.encode("latin1", errors="ignore")
        .str.decode("utf-8", errors="ignore")
    )

# Numéricos com vírgula
df["igr"] = (
    df["igr"]
      .str.replace(",", ".", regex=False)
      .astype(float)
)

# Inteiros
int_cols = [
    "registro_ans",
    "qtd_reclamacoes",
    "qtd_beneficiarios",
    "competencia",
    "competencia_beneficiario"
]

df[int_cols] = (
    df[int_cols]
      .apply(pd.to_numeric, errors="coerce")
      .astype("Int64")
)

# Datas
df["dt_atualizacao"] = pd.to_datetime(
    df["dt_atualizacao"],
    dayfirst=True,
    errors="coerce"
)

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
        "stg_igr",
        con=conn,
        if_exists="append",
        index=False,
        chunksize=2000
    )

print("ETL do IGR concluído com sucesso.")
