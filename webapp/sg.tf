resource "aws_security_group" "instance" {
	name = "instance-terraform"
	vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
	ingress = {
		from_port  = "${var.server_port}"
		to_port    = "${var.server_port}"
		protocol   = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	lifecycle {
		create_before_destroy = true
	}
}
resource "aws_security_group" "elb" {
	name = "elb-terraform"
	vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
	ingress = {
		from_port  = "80"
		to_port    = "80"
		protocol   = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	lifecycle {
		create_before_destroy = true
	}
}
