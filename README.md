# Once you're done running the bashscript, and your Prometheus server and service runs fine, now edit the Prometheus configuration file.
# The prometheus.yml file is where you configure Prometheus to scrape metrics from different targets. Here's a basic example of a prometheus.yml configuration file:
sudo nano /etc/prometheus/prometheus.yml

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]

    scrape_interval: 15s
  - job_name: 'localhost'
    static_configs:
      - targets: ['localhost:9100']

   - job_name: 'windows-server'
    scrape_interval: 5s
    static_configs:
      - targets: ['10.0.0.x:9182']

  - job_name: 'Prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['10.0.0.x:9090']
