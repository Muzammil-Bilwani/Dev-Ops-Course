# Week 11: Monitoring with Grafana

In this week, we will dive into **monitoring and observability** using **Grafana**.  
You’ll learn how to collect metrics, visualize them in dashboards, and set up alerts to know when your systems misbehave.

---

## 📌 Topics Covered

1. **Metrics and Logging Fundamentals**
2. **Setting up Grafana Dashboards**
3. **Connecting Grafana to Data Sources**
4. **Hands-on: Visualizing App Performance and Alerts**

---

## 1. Metrics and Logging Fundamentals

### 🔹 What are Metrics?

- **Metrics** are numeric measurements about your system.  
  Examples:
  - CPU usage (%)
  - Memory consumption (MB)
  - Request latency (ms)
  - Number of errors per minute

👉 Think of metrics like your **car dashboard** – speed, fuel, temperature.

### 🔹 What is Logging?

- **Logs** are textual records of events happening in your system.  
  Examples:
  - API request logs
  - Database query logs
  - Error stack traces

👉 Logs = **detailed diary entries** about what happened.

---

## 2. Setting up Grafana Dashboards

Grafana is like a **control room** for your system.

### Steps:

1. Install Grafana (locally or via Docker):

   ```bash
   docker run -d -p 3000:3000 grafana/grafana
   ```

   Access it at [http://localhost:3000](http://localhost:3000).  
   Default login: `admin / admin`.

2. Create your first dashboard:
   - Click **+ → Dashboard → Add a new panel**
   - Choose a metric (e.g., CPU usage)
   - Select visualization type (Graph, Gauge, Bar, etc.)
   - Save dashboard

### Example Dashboard Ideas:

- **System Health Dashboard**
  - CPU Usage (line chart)
  - Memory Usage (gauge)
  - Requests per second (bar chart)
  - Error rate (red alert line)

---

## 3. Connecting Grafana to Data Sources

Grafana **needs data** to visualize.  
Common data sources:

- **Prometheus** → for metrics
- **Loki** → for logs
- **ElasticSearch** → for searching logs/metrics
- **MySQL/Postgres** → for custom queries

### Example: Connect Grafana with Prometheus

1. Run Prometheus with Docker:
   ```bash
   docker run -d -p 9090:9090 prom/prometheus
   ```
2. In Grafana:

   - Go to **Connections → Data Sources → Add data source**
   - Select **Prometheus**
   - URL: `http://localhost:9090`
   - Save & Test

3. Now you can query metrics like:
   ```
   rate(http_requests_total[1m])
   ```

---

## 4. Hands-on: Visualize App Performance and Alerts

### 🛠 Practical Example: Node.js App + Prometheus + Grafana

1. Install **Prometheus Client** in Node.js app:
   ```bash
   yarn add prom-client express
   ```
2. Expose metrics in your app:

   ```js
   const express = require("express");
   const client = require("prom-client");

   const app = express();
   const collectDefaultMetrics = client.collectDefaultMetrics;
   collectDefaultMetrics();

   app.get("/metrics", async (req, res) => {
     res.set("Content-Type", client.register.contentType);
     res.end(await client.register.metrics());
   });

   app.listen(process.env.PORT || 3000, () => {
     console.log("Server running...");
   });
   ```

3. Configure Prometheus (`prometheus.yml`):

   ```yaml
   scrape_configs:
     - job_name: "node_app"
       static_configs:
         - targets: ["host.docker.internal:3000"]
   ```

4. Add Prometheus as a Grafana data source.

5. Create dashboards:
   - Requests per second
   - Average response time
   - Memory usage

---

### 🚨 Setting up Alerts in Grafana

1. Go to your panel → **Alert → Create alert rule**
2. Example rule:
   - **Condition:** CPU usage > 80% for 5 minutes
   - **Action:** Send email/Slack notification
3. Save & test alert

---

## ✅ Summary

By the end of this week, you will:

- Understand **metrics vs logs**
- Know how to **set up Grafana dashboards**
- Connect **Grafana with Prometheus**
- **Visualize real app performance**
- Configure **alerts for critical issues**

👉 You now have a **monitoring stack** that helps detect problems before users complain!
