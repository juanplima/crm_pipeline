# 🔄 CRM Data Pipeline

Pipeline de dados end-to-end para ingestão, transformação e modelagem de dados de CRM, utilizando Apache Airflow, Python, DBT e MySQL.

---

## 📌 Sobre o projeto

Pipeline orquestrado com Airflow que extrai dados brutos de arquivos CSV, realiza transformações e padronizações com Python e Pandas, carrega os dados em um banco relacional e aplica modelagem analítica com DBT, seguindo as boas práticas de engenharia de dados com separação clara entre camada raw e camada analítica.

---

## 🏗️ Arquitetura

[CSV Files]
↓
[Python ETL — Pandas]
↓
[Database — Raw Layer]
↓
[DBT Transformations]
↓
[Camada Analítica]

---

## ⚙️ Orquestração com Airflow

A DAG `pipeline_crm` executa diariamente e é composta por duas etapas principais:

### 🔹 1. ETL — PythonOperator
Executa o script `etl.py`, responsável por:
- Leitura dos arquivos CSV
- Tratamento e padronização dos dados
- Carga nas tabelas raw do banco de dados

### 🔹 2. Transformação — BashOperator
Executa `dbt run` para modelar os dados na camada analítica.

### 📅 Agendamento
- **Frequência:** `@daily`
- **Catchup:** desabilitado

---

## 🔄 Processo de ETL

### 📥 Extração
Leitura dos seguintes arquivos:

| Arquivo | Descrição |
|---|---|
| `accounts.csv` | Contas e clientes |
| `products.csv` | Catálogo de produtos |
| `sales_pipeline.csv` | Pipeline de vendas |
| `sales_teams.csv` | Estrutura do time comercial |

### 🔧 Transformação
Principais regras aplicadas:

- Padronização de nomes de colunas para PT-BR
- Tradução de valores categóricos:

| Original | Traduzido |
|---|---|
| Won | ganho |
| Lost | perdido |
| Prospecting | prospeccao |
| Engaging | engajamento |

- Ajuste de nomenclaturas de regiões

### 📤 Carga
Os dados são carregados no banco nas seguintes tabelas:

| Tabela | Descrição |
|---|---|
| `raw_accounts` | Contas e clientes |
| `raw_produtos` | Produtos |
| `raw_vendas_pipeline` | Pipeline de vendas |
| `raw_time_vendas` | Estrutura do time comercial |

---

## 🛠️ Stack

| Tecnologia | Uso |
|---|---|
| Apache Airflow | Orquestração do pipeline |
| Python 3 | Linguagem principal |
| Pandas | Transformação e padronização dos dados |
| SQLAlchemy | Conexão e carga no banco de dados |
| DBT | Modelagem e transformação analítica |
| MySQL | Banco de dados relacional |

---

## 📁 Estrutura do projeto
crm-data-pipeline/
├── dags/
│   ├── pipeline_crm.py       # DAG principal do Airflow
│   ├── etl.py                # Script de extração e carga
│   └── crm_pipeline/         # Projeto DBT
├── data/
│   ├── accounts.csv
│   ├── products.csv
│   ├── sales_pipeline.csv
│   └── sales_teams.csv
├── .env
└── README.md]]---

## ⚙️ Como rodar localmente

### Pré-requisitos
- Python 3.8+
- Apache Airflow
- MySQL
- DBT

### Configuração

Cria um arquivo `.env` na raiz do projeto:]DB_USER=seu_usuario
DB_PASS=sua_senha
DB_HOST=seu_host
DB_NAME=seu_banco

### Execução

```bash
# Inicia o Airflow
airflow standalone

# A DAG pipeline_crm será executada automaticamente no agendamento
# ou pode ser disparada manualmente pelo Airflow UI
```

---

## 📈 Possíveis evoluções

- [ ] Migrar ingestão para processamento distribuído com Spark
- [ ] Armazenamento em Data Lake (S3)
- [ ] Implementar camadas Bronze / Silver / Gold
- [ ] Testes de qualidade de dados com DBT tests
- [ ] Monitoramento e alertas via Slack ou e-mail
- [ ] Incremental load ao invés de full replace

---

## 💡 Diferenciais do projeto

- Pipeline completo com orquestração e transformação
- Separação clara entre camada de ingestão e camada analítica
- Boas práticas de engenharia de dados aplicadas
- Estrutura modular e pronta para escalar
- 
