import os

from dotenv import load_dotenv
from locust import HttpUser, between, task

BASEDIR = os.path.abspath(os.path.dirname(__file__))
load_dotenv(os.path.join(BASEDIR, '.env'))

base_url = os.environ.get("BASE_URL")


class QuickstartUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def health(self):
        self.client.get("/api/health")

    @task(3)
    def sum(self):
        self.client.post("/api/sum", json={"num1": 10, "num2": 50})

    @property
    def host(self):
        return os.environ.get("BASE_URL", "http://127.0.0.1:8000")
