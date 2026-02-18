import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv 
import os 

load_dotenv()
db_url = os.getenv("DB_URL")

data_path = os.getenv("DATA_PATH")

df_accounts = pd.read_csv(rf"{data_path}\accounts.csv", sep=",")
df_products = pd.read_csv(rf"{data_path}\products.csv", sep=",")
df_sales_pipeline = pd.read_csv(rf"{data_path}\sales_pipeline.csv", sep=",")
df_sales_teams = pd.read_csv(rf"{data_path}\sales_teams.csv", sep=",")

engine = create_engine(db_url)

df_accounts.columns = ["conta", "setor", "ano_fundacao", "receita", "funcionarios", "localizacao", "subsidiaria_de"]
df_products.columns = ["produto", "modelo", "preco_venda"]

df_sales_pipeline["deal_stage"] = df_sales_pipeline["deal_stage"].replace({
    "Won": "ganho",
    "Lost": "perdido",
    "Prospecting": "prospeccao",
    "Engaging": "engajamento"
})
df_sales_pipeline.columns = ["id_da_oportunidade","vendedor","produto","conta","estagio_negociacao","data_de_engajamento","data_fechamento","fechamento_valor"]

df_sales_teams["regional_office"] = df_sales_teams["regional_office"].replace({
    "East": "Leste",
    "Central": "Central"
})

df_sales_teams.columns = ["vendedor","gerente","escritorio"]

df_accounts.to_sql(
    "raw_accounts",
    con=engine,        
    if_exists="replace",
    index=False,
    chunksize=1000
)
df_products.to_sql(
    "raw_produtos",
    con=engine,        
    if_exists="replace",
    index=False,
    chunksize=1000
)

df_sales_pipeline.to_sql(
    "raw_vendas_pipeline",
    con=engine,        
    if_exists="replace",
    index=False,
    chunksize=1000
)

df_sales_teams.to_sql(
    "raw_time_vendas",
    con=engine,        
    if_exists="replace",
    index=False,
    chunksize=1000
)

