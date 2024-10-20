from airflow import DAG
from airflow.operators.empty import EmptyOperator
from pendulum import datetime

from cosmos.providers.dbt.core.operators import DbtRunOperator

# Define the DAG
with DAG(
    dag_id="dbt_run_all_models_cosmos",
    start_date=datetime(2024, 1, 1),
    schedule=None,
    catchup=False,
    max_active_runs=1,
) as dag:

    # Start task
    start_task = EmptyOperator(
        task_id="start",
    )

    # DBT run task to run all models
    run_all_models = DbtRunOperator(
        task_id="run_all_models",
        select="*",  # Run all models
        project_dir="/usr/local/airflow/dbt/my_project",  # Update with your DBT project path
        schema="public",
        dbt_executable_path="/usr/local/airflow/dbt_venv/bin/dbt",  # Update with your DBT virtual environment
        conn_id="snowflake_conn",  # Your DB connection ID
    )

    # End task
    end_task = EmptyOperator(
        task_id="end",
    )

    # Set dependencies: start -> run_all_models -> end
    start_task >> run_all_models >> end_task
