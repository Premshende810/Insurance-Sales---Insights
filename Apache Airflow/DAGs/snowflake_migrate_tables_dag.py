from airflow import DAG
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago
from datetime import timedelta

# Define the default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
with DAG(
    dag_id='snowflake_migrate_tables_dag',
    default_args=default_args,
    description='Daily migration of tables from source to target schema in Snowflake',
    schedule_interval='@daily',  # Runs daily
    start_date=days_ago(1),  # Start date for the DAG, can be adjusted
    catchup=False,  # Skip backfilling for past dates
) as dag:

    # Define the start task
    start = DummyOperator(
        task_id='start'
    )

    # Snowflake SQL command to call the procedure
    migrate_tables = SnowflakeOperator(
        task_id='migrate_tables',
        snowflake_conn_id='my_snowflake_connection',  # Replace with your Airflow connection ID for Snowflake
        sql="CALL SP_MIGRATE_TABLE_DDLS('DEV_ENV', 'DBT_DEV', 'PROD_ENV', 'DBT_ENV', 'Y', 'Y');"
    )

    # Define the end task
    end = DummyOperator(
        task_id='end'
    )

    # Set task dependencies
    start >> migrate_tables >> end
