from airflow import DAG
from airflow.operators.empty import EmptyOperator
from pendulum import datetime

from cosmos.providers.dbt.core.operators import DbtRunOperator

# Define the DAG
with DAG(
    dag_id="dbt_run_models_cosmos",
    start_date=datetime(2024, 1, 1),
    schedule=None,
    catchup=False,
    max_active_runs=1,
) as dag:

    # Start task
    start_task = EmptyOperator(
        task_id="start",
    )

    # DBT run task for dim_agents.sql
    run_agents = DbtRunOperator(
        task_id="run_dim_agents",
        select="dim_agents.sql",
        project_dir="/usr/local/airflow/dbt/my_project",  # Update with your DBT project path
        schema="public",
        dbt_executable_path="/usr/local/airflow/dbt_venv/bin/dbt",  # Update with your DBT virtual environment
        conn_id="snowflake_conn",  # Your DB connection ID
    )

    # DBT run task for car.sql
    run_car = DbtRunOperator(
        task_id="run_car",
        select="car.sql",
        project_dir="/usr/local/airflow/dbt/my_project",  # Update with your DBT project path
        schema="public",
        dbt_executable_path="/usr/local/airflow/dbt_venv/bin/dbt",
        conn_id="snowflake_conn",
    )

    # End task
    end_task = EmptyOperator(
        task_id="end",
    )

    # Set dependencies: start -> run_dim_agents -> run_car -> end
    start_task >> run_dim_agents >> run_car >> end_task
