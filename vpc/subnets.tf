# Subnets

resource "aws_subnet" "public-1a" {
	vpc_id = "${aws_vpc.terraform.id}"
	cidr_block = "10.0.0.0/24"
	availability_zone = "us-east-1a"
	map_public_ip_on_launch = false
	depends_on = ["aws_internet_gateway.internet_gw"]
	tags {
		Name = "public-1a"
	}
}

resource "aws_subnet" "public-1b" {
	vpc_id = "${aws_vpc.terraform.id}"
	cidr_block = "10.0.1.0/24"
	availability_zone = "us-east-1b"
	map_public_ip_on_launch = false
	depends_on = ["aws_internet_gateway.internet_gw"]
	tags {
		Name = "public-1b"
	}
}

resource "aws_subnet" "private-1a" {
	vpc_id = "${aws_vpc.terraform.id}"
	cidr_block = "10.0.5.0/24"
	availability_zone = "us-east-1a"
	map_public_ip_on_launch = false
	tags {
		Name = "private-1a"
	}
}

resource "aws_subnet" "private-1b" {
	vpc_id = "${aws_vpc.terraform.id}"
	cidr_block = "10.0.6.0/24"
	availability_zone = "us-east-1b"
	map_public_ip_on_launch = false
	tags {
		Name = "private-1b"
	}
}

# NAT Gateway

resource "aws_eip" "nat_gw" {
	vpc = true
}

resource "aws_route" "nat_route" {
	route_table_id = "${aws_route_table.private.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
}

resource "aws_nat_gateway" "nat_gw" {
	allocation_id = "${aws_eip.nat_gw.id}"
	subnet_id     = "${aws_subnet.public-1a.id}"
	depends_on = ["aws_internet_gateway.internet_gw"] 
}

resource "aws_route_table_association" "private-1a" {
	subnet_id = "${aws_subnet.private-1a.id}"
	route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "private-1b" {
	subnet_id = "${aws_subnet.private-1b.id}"
	route_table_id = "${aws_route_table.private.id}"
}
