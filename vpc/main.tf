provider "aws" {
	region = "${var.region}"
	profile = "${var.profile}"
}

resource "aws_vpc" "terraform" {
	cidr_block = "10.0.0.0/16"
	tags {
		Name = "terraform"
	}
}

resource "aws_internet_gateway" "internet_gw" {
	vpc_id = "${aws_vpc.terraform.id}"
	tags {
		Name = "terraform-gw"
	}
}

resource "aws_default_route_table" "default_rt" {
	default_route_table_id = "${aws_vpc.terraform.default_route_table_id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.internet_gw.id}"
	}
	tags {
		Name = "default table"
	}
}

resource "aws_route_table" "private" {
	vpc_id = "${aws_vpc.terraform.id}"
	tags {
		Name = "private"
	}
}
