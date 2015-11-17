# Specify the provider and access details
provider "aws" {
    # we'll source it from AWS_ACCESS_KEY_ID in the environment
#   access_key = "${var.aws_access_key}"
    # we'll source it from AWS_SECRET_ACCESS_KEY in the environment
#   secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
    max_retries = 10
}

resource "aws_security_group" "allow_all" {
    name = "allow_all"
    description = "Allow all inbound traffic"
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name = "Allow All Traffic"
        realm = "experimental"
        purpose = "monitoring-simulation"
        created-by = "Terraform"
    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags {
        Name = "Monitoring Simulation"
        realm = "experimental"
        purpose = "monitoring-simulation"
        created-by = "Terraform"
    }
}

resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.0.0/24" 
    map_public_ip_on_launch = true

    tags {
        Name = "Docker Boxes"
        realm = "experimental"
        purpose = "monitoring-simulation"
        created-by = "Terraform"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "Monitoring Simulation"
        realm = "experimental"
        purpose = "monitoring-simulation"
        created-by = "Terraform"
    }
}

resource "aws_route_table" "main" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }

    tags {
        Name = "Monitor Simulation"
        realm = "experimental"
        purpose = "monitoring-simulation"
        created-by = "Terraform"
    }
}

resource "aws_main_route_table_association" "main" {
    vpc_id = "${aws_vpc.main.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_instance" "new_relic" {
    connection {
        user = "ubuntu"
        key_file = "${lookup(var.key_path, var.aws_region)}"
    }
    depends_on = ["aws_internet_gateway.main"]
    count = 1 
    ami = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.instance_type}"
    key_name = "${lookup(var.key_name, var.aws_region)}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    subnet_id = "${aws_subnet.main.id}"

    tags {
        Name = "New Relic"
        realm = "experimental"
        purpose = "monitoring-simulation"
        created-by = "Terraform"
    }
}

resource "aws_eip" "new_relic" {
    instance = "${aws_instance.new_relic.id}"
    vpc = true
}

resource "aws_instance" "data_dog" {
    connection {
        user = "ubuntu"
        key_file = "${lookup(var.key_path, var.aws_region)}"
    }
    depends_on = ["aws_internet_gateway.main"]
    count = 1
    ami = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.instance_type}"
    key_name = "${lookup(var.key_name, var.aws_region)}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    subnet_id = "${aws_subnet.main.id}"

    tags {
        Name = "Data Dog"
        realm = "experimental"
        purpose = "monitoring-simulation"
        created-by = "Terraform"
    }
}

resource "aws_eip" "data_dog" {
    instance = "${aws_instance.data_dog.id}"
    vpc = true
}

