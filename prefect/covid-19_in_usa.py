# import all of necessary libraries & components
import datetime as dt
import json
import psycopg2
import requests
from prefect.schedules import Schedule
from prefect.schedules.clocks import CronClock
from prefect.client import Secret
from prefect import task, Flow
from prefect.executors import LocalDaskExecutor
from prefect.storage.github import GitHub

# set daily-morning schedule
schedule = Schedule(clocks=[CronClock("30 7 * * *")])

# use Vault for credentials
database_secret = Secret("database").get()

# set variables & database connections
day = dt.date.today() - dt.timedelta(days = 1)
url = f"https://api.covid19api.com/live/country/usa/status/active/date/{day}"

connect = psycopg2.connect(
    dbname = database_secret["dbname"],
    user = database_secret["user"],
    password = database_secret["password"],
    host = database_secret["host"],
    port = int(database_secret["port"])
)


# describe the dataflow tasks
@task(log_stdout=True)
def get_data_from_api():
    r = requests.request("GET", url)
    response = r.json()
    return response

@task(log_stdout=True)
def truncate_table():
    cursor = connect.cursor()
    try:
        cursor.execute("truncate table demo.covid.stats")
    finally:
        connect.commit()
        cursor.close()

@task(log_stdout=True)
def insert_data(response):
    for i in response:
        cursor = connect.cursor()
        try:
            cursor.execute(f"insert into demo.covid.stats (json_data, meta_timestamp) values ('{json.dumps(i)}', '{dt.datetime.now()}')")
        finally:
            connect.commit()
            cursor.close()
    connect.close()

# declare the dataflow
with Flow("COVID-19_in_USA", schedule = schedule) as flow:
    insert_data(get_data_from_api(), upstream_tasks = [truncate_table()])
flow.storage = GitHub(access_token_secret = "github",
                      repo = "d-step-co/COVID-19_in_USA",
                      path = "prefect/covid-19_in_usa.py")
flow.executor = LocalDaskExecutor()
flow.register(project_name = "COVID-19 in USA", labels = ["demo_project"])
# flow.run(run_on_schedule=False)