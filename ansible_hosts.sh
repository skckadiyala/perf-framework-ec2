# generator=$(terraform output ec2_perf-generator_ips)


cat > ansible_hosts << EOF

[backend]
$(terraform output ec2_backend_ip) ansible_user=ubuntu ansible_ssh_private_key_file=falcons-apigw-key-pair

[generator]
$(terraform output ec2_generator_ip) ansible_user=ubuntu ansible_ssh_private_key_file=falcons-apigw-key-pair install_dir=~/PERF_CLIENT

[monitoring]
$(terraform output ec2_monitoring_ip) ansible_user=ubuntu ansible_ssh_private_key_file=falcons-apigw-key-pair

[prometheus]
$(terraform output ec2_prometheus_ip) ansible_user=ubuntu ansible_ssh_private_key_file=falcons-apigw-key-pair

EOF

cat > ./framework/prometheus-server/prometheus.yml << EOF
global:
  scrape_interval: 15s
scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 10s
    static_configs:
      - targets: ['$(terraform output ec2_prometheus_ip):9090']
  - job_name: 'Backend'
    scrape_interval: 10s
    static_configs:
      - targets: ['$(terraform output ec2_backend_ip):9100'] 
  - job_name: 'Generator'
    scrape_interval: 10s
    static_configs:
      - targets: ['$(terraform output ec2_generator_ip):9100']    
EOF
