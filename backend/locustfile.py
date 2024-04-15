import time

from locust import HttpUser, between, task


class QuickstartUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def health(self):
        self.client.get("/api/health")

    @task(3)
    def sum(self):
        self.client.post("/api/sum", json={"num1": 10, "num2": 50})
