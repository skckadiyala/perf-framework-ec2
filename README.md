# Create Infra and Deploy Performance test framrwork
Terraform is used to create infrastructure on AWS.
Ansible is used to deploy the performance test framework

Using Terraform scripts, It creates; 
* 1 VPC, 
* 1 public subnet, 
* 1 Internet Gateway, 
* 1 Security Group
* 4 EC2

Using Ansible scripts deploy following components 
* Java
* JMeter 5.0
* Nginx
* InfluxDB and Influx-Client
* Prometheues

```
ssh-keygen -f falcons-apigw-key-pair

./infra-framework-deploy.sh

```