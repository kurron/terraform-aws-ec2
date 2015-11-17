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

