variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-west-2"
}

variable "instance_type" {
    description = "AWS EC2 instance type."
#   default = "t2.micro"
#   default = "t2.small"
#   default = "t2.medium"
    default = "t2.large"
}

variable "docker_instance_count" {
    description = "How many Docker instances to spin up."
    default = 1 
}

variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
    default = {
        us-east-1      = "us-east-1"
        us-west-1      = "us-west-1"
        us-west-2      = "kurr-experiments"
        eu-west-1      = "eu-west-1"
        eu-central-1   = "eu-central-1"
        sa-east-1      = "sa-east-1"
        ap-southeast-1 = "ap-southeast-1"
        ap-southeast-2 = "ap-southeast-2"
        ap-northeast-1 = "ap-northeast-1"
    }
}

variable "key_path" {
    description = "Path to the private portion of the SSH key specified."
    default = {
        us-east-1      = "/home/vagrant/aws/us-east-1.pem"
        us-west-1      = "/home/vagrant/aws/us-west-1.pem"
        us-west-2      = "/home/vagrant/GitHub/terraform-monitor/kurr-experiments.pem"
        eu-west-1      = "/home/vagrant/aws/eu-west-1.pem"
        eu-central-1   = "/home/vagrant/aws/eu-central-1.pem"
        sa-east-1      = "/home/vagrant/aws/sa-east-1.pem"
        ap-southeast-1 = "/home/vagrant/aws/ap-southeast-1.pem"
        ap-southeast-2 = "/home/vagrant/aws/ap-southeast-2.pem"
        ap-northeast-1 = "/home/vagrant/aws/ap-northeast-1.pem"
    }
}

# Ubuntu Server 14.04 LTS (HVM), SSD Volume Type, 64-bit 
variable "aws_amis" {
    description = "AMI to build the instance from."
    default = {
        us-east-1      = "ami-81ea1aea"
        us-west-1      = "ami-df6a8b9b"
        us-west-2      = "ami-5189a661"
        eu-west-1      = "ami-47a23a30"
        eu-central-1   = "ami-accff2b1"
        sa-east-1      = "ami-4d883350"
        ap-southeast-1 = "ami-96f1c1c4"
        ap-southeast-2 = "ami-69631053"
        ap-northeast-1 = "ami-936d9d93"
    }
}

