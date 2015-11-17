provider "aws" {
    # we'll source it from AWS_ACCESS_KEY_ID in the environment
    # we'll source it from AWS_SECRET_ACCESS_KEY in the environment
    region = "${var.aws_region}"
    max_retries = 10
}

resource "aws_subnet" "subnet" {
    count = "${var.subnet_instance_count}"

    availability_zone = "${lookup(var.availability_zone, count.index)}"
    cidr_block = "${lookup(var.public_cidr, count.index)}" 
    vpc_id = "${var.vpc_id}"
    map_public_ip_on_launch = true

    tags {
        Name = "${lookup(var.subnet_name, count.index)}"
        Realm = "${var.realm}"
        Managed-By = "${var.managed_by}"
    }
}

resource "aws_security_group" "docker_traffic" {
    name = "docker-traffic"
    description = "Allow inbound and outbound access on ALL ports."
    vpc_id = "${var.vpc_id}"
    tags {
        Name = "Docker Traffic"
        Realm = "${var.realm}"
        Managed-By = "${var.managed_by}"
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

resource "aws_instance" "docker" {
    count = "${var.docker_instance_count}"

    ami = "${lookup(var.aws_amis, var.aws_region)}"
    availability_zone = "${lookup(var.availability_zone, count.index)}"
    ebs_optimized = "false"
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "stop"

    instance_type = "${var.docker_instance_type}"
    key_name = "${lookup(var.key_name, var.aws_region)}"
    monitoring = true
    vpc_security_group_ids = ["${aws_security_group.docker_traffic.id}"]
    subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
    associate_public_ip_address = true
    private_ip ="${lookup(var.docker_private_ip, count.index)}"
    source_dest_check = false

    root_block_device { 
        volume_type = "gp2"
        volume_size = 8
        delete_on_termination = true
    }

    tags {
        Name = "Docker ${lookup(var.subnet_name, count.index)}"
        Realm = "${var.realm}"
        Managed-By = "${var.managed_by}"
    }
}
