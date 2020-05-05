#/bin/bash


# ssh-keygen -f falcons-apigw-key-pair

terraform init
terraform validate

terraform plan -out terraform.out
terraform apply terraform.out

./ansible_hosts.sh

export ANSIBLE_HOST_KEY_CHECKING=false
ansible-playbook -i ansible_hosts ./framework/java/install.yml
ansible-playbook -i ansible_hosts ./framework/jmeter/essential.yml

ansible-playbook -i ansible_hosts ./framework/node-exporter/install-node-exporter.yml
ansible-playbook -i ansible_hosts ./framework/prometheus-server/install-prom-server.yml 

ansible-playbook -i ansible_hosts ./framework/monitoring/install.yml
ansible-playbook -i ansible_hosts ./framework/nginx/install.yml

