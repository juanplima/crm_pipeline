*CRM Data Pipeline (Airflow + DBT + Python + MySql)*

Pipeline de dados end-to-end para ingestão, transformação e modelagem de dados de CRM, utilizando Apache Airflow, Python (Pandas), SQLAlchemy e DBT.

 Visão Geral

Este projeto implementa um pipeline orquestrado com Airflow que:

- Extrai dados de arquivos CSV
- Transforma e padroniza os dados com Python (Pandas)
- Carrega os dados em um banco relacional
- Executa transformações analíticas com DBT

🏗️ Arquitetura

  [CSV Files] 
       ↓
  [Python ETL (Pandas)]
       ↓
  [Database - Raw Layer]
       ↓
  [DBT Transformations]
       ↓
  [Camada Analítica]

⚙️ Orquestração (Airflow)

A DAG pipeline_crm executa diariamente e possui duas etapas principais:

🔹 1. ETL (PythonOperator)

Executa o script etl.py, responsável por:

- Leitura dos CSVs
- Tratamento e padronização dos dados
- Carga no banco de dados
  
🔹 2. Transformação (BashOperator)

Executa: dbt run 

Responsável por modelar os dados na camada analítica.

📅 Agendamento
- Frequência: @daily
- Catchup: desabilitado

  📂 Estrutura do Projeto
      
    ├── dags/
    │   ├── pipeline_crm.py
    │   ├── etl.py
    │   └── crm_pipeline/   # projeto DBT
    │
    ├── data/
    │   ├── accounts.csv
    │   ├── products.csv
    │   ├── sales_pipeline.csv
    │   └── sales_teams.csv
    │
    ├── .env
    └── README.md

  🔄 Processo de ETL
📥 Extração

Leitura dos arquivos:

- accounts.csv
- products.csv
- sales_pipeline.csv
- sales_teams.csv
  
🔧 Transformação

Principais regras aplicadas:

- Padronização de colunas (PT-BR)
- Tradução de valores categóricos:
- Won → ganho
- Lost → perdido
- Prospecting → prospeccao
- Engaging → engajamento
- Ajuste de nomenclaturas de regiões

  📤 Carga

Os dados são carregados no banco nas seguintes tabelas:

  | Tabela                | Descrição                   |
  | --------------------- | --------------------------- |
  | `raw_accounts`        | Contas/clientes             |
  | `raw_produtos`        | Produtos                    |
  | `raw_vendas_pipeline` | Pipeline de vendas          |
  | `raw_time_vendas`     | Estrutura do time comercial |

  🛠️ Tecnologias Utilizadas
   -  Apache Airflow
    - Python
    - Pandas
    - SQLAlchemy
    - DBT
    - MySQL
      
 📈 Possíveis Evoluções
  🔹 Migrar ingestão para processamento distribuído (Spark)
  🔹 Armazenamento em Data Lake (S3)
  🔹 Camadas Bronze / Silver / Gold
  🔹 Testes de qualidade de dados (DBT tests)
  🔹 Monitoramento e alertas (Slack / Email)
  🔹 Incremental load ao invés de replace

  💡 Diferenciais do Projeto
    - Pipeline completo (orquestração + transformação)
    - Separação clara entre ingestão e modelagem
    - Uso de boas práticas de engenharia de dados
    - Estrutura pronta para escalar
  
