from locust import HttpUser, between, task


class QuickstartUser(HttpUser):
    wait_time = between(1, 5)
    health_success_count = 0
    health_total_requests = 0
    sum_success_count = 0
    sum_total_requests = 0

    @task
    def health(self):
        response = self.client.get("/api/health")
        self.health_total_requests += 1

        if response.status_code == 200:
            self.health_success_count += 1

    @task(3)
    def sum(self):
        response = self.client.post("/api/sum", json={"num1": 10, "num2": 50})
        self.sum_total_requests += 1

        if response.status_code == 200:
            self.sum_success_count += 1

    def on_stop(self):
        health_success_rate = self.health_success_count / self.health_total_requests
        sum_success_rate = self.sum_success_count / self.sum_total_requests
        assert health_success_rate > 0.95, f"Health success rate: {health_success_rate}"
        assert sum_success_rate > 0.95, f"Sum success rate: {sum_success_rate}"
