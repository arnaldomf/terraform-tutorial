provider "aws" {
	region = "${var.region}"
	profile = "${var.profile}"
}

resource "aws_launch_configuration" "example" {
	image_id = "${var.ami}"
	instance_type = "t2.micro"
	security_groups = ["${aws_security_group.instance.id}"]

	user_data = <<-EOF
#!/bin/bash
echo "Hello World" > index.html
nohup busybox httpd -f -p "${var.server_port}" &
	EOF

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_autoscaling_group" "example" {
	launch_configuration = "${aws_launch_configuration.example.id}"
	min_size = 1
	max_size = 1
	# data -> datasource
	availability_zones = ["${data.aws_availability_zones.available.names}"]

	tag {
		key = "Name"
		value = "terraform-asg-example"
		propagate_at_launch = true
	}
}

resource "aws_security_group" "instance" {
	name = "terraform-example-instance"
	vpc_id = "${var.vpc_id}"
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
