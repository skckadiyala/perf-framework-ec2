resource "aws_instance" "perf-nginx" {
  ami           = var.AMI[var.AWS_REGION]
  instance_type = "m5.large"

  tags = {
    Name = "falcons-backend"
  }

  # VPC
  subnet_id = aws_subnet.falcons-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = [aws_security_group.ssh-allowed.id]

  # the Public SSH key
  key_name = aws_key_pair.falcons-apigw-key-pair.id

  provisioner "file" {
    source      = "bootup.sh"
    destination = "/tmp/bootup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootup.sh",
      "sudo /tmp/bootup.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.EC2_USER
    private_key = file(var.PRIVATE_KEY_PATH)
  }
}

resource "aws_key_pair" "falcons-apigw-key-pair" {
  key_name   = "falcons-apigw-key-pair"
  public_key = file(var.PUBLIC_KEY_PATH)
}

resource "aws_instance" "perf-generator" {
  ami           = var.AMI[var.AWS_REGION]
  instance_type = "m5.xlarge"

  tags = {
    Name = "falcons-generator"
  }

  # VPC
  subnet_id = aws_subnet.falcons-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = [aws_security_group.ssh-allowed.id]

  # the Public SSH key
  key_name = aws_key_pair.falcons-apigw-key-pair.id

}

resource "aws_instance" "perf-prometheus" {
  ami           = var.AMI[var.AWS_REGION]
  instance_type = "t2.medium"

  tags = {
    Name = "falcons-prometheus"
  }

  # VPC
  subnet_id = aws_subnet.falcons-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = [aws_security_group.ssh-allowed.id]

  # the Public SSH key
  key_name = aws_key_pair.falcons-apigw-key-pair.id

}

resource "aws_instance" "perf-monitoring" {
  ami           = var.AMI[var.AWS_REGION]
  instance_type = "t2.medium"

  tags = {
    Name = "falcons-monitoring"
  }

  # VPC
  subnet_id = aws_subnet.falcons-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = [aws_security_group.ssh-allowed.id]

  # the Public SSH key
  key_name = aws_key_pair.falcons-apigw-key-pair.id

}

output "ec2_backend_ip" {
  value = aws_instance.perf-nginx.public_ip
}
output "ec2_monitoring_ip" {
  value = aws_instance.perf-monitoring.public_ip
}
output "ec2_prometheus_ip" {
  value = aws_instance.perf-prometheus.public_ip
}
output "ec2_generator_ip" {
  value = aws_instance.perf-generator.public_ip
}