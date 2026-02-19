from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from datetime import datetime

def rodar_etl():
    import subprocess
    subprocess.run(["python", "/opt/airflow/dags/etl.py"], check=True)

with DAG(
    dag_id="pipeline_crm",          
    start_date=datetime(2024, 1, 1),
    schedule_interval="@daily",      
    catchup=False                    
) as dag:
        etl = PythonOperator(
            task_id="carregar_csvs",
            python_callable=rodar_etl
        )

        dbt = BashOperator(
            task_id="rodar_dbt",
            bash_command="cd /opt/airflow/dags/crm_pipeline && dbt run"
        )

        etl >> dbt  