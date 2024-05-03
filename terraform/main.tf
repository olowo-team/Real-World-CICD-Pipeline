// main.tf

module "aws_provider" {
  source = "./provider"
  region = "us-east-1"  // Change to your desired region
}

module "olowo_sg" {
  source = "./security_group"
  security_group_name = "olowo-sg"

  ingress_rules = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 9100
      to_port     = 9100
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    // Add additional ingress rules as needed for other ports
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "jenkins_maven_ansible_instance" {
  source = "./instance"
  instance_name = "jenkins-maven-ansible"
  ami_id = "ami-0c55b159cbfafe1f0"  // Amazon Linux 2 AMI ID
  instance_type = "t2.medium"
  security_group_name = module.olowo_sg.security_group_name
}

module "sonarqube_instance" {
  source = "./instance"
  instance_name = "sonarqube"
  ami_id = "ami-09e67e426f25ce0d7"  // Ubuntu 20.04 AMI ID
  instance_type = "t2.medium"
  security_group_name = module.olowo_sg.security_group_name
}

// Define other instances similarly (Nexus, Dev/Stage/Prod, Prometheus, Grafana, Splunk)
