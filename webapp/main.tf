provider "aws" {
	profile = "${var.profile}"
	region  = "${var.region}"
}

resource "aws_launch_configuration" "example" {
	image_id = "${data.aws_ami.ubuntu.id}"
	instance_type = "t2.micro"
	security_groups = ["${aws_security_group.instance.id}"]
	user_data = "${data.template_file.user-data.rendered}"

	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_autoscaling_group" "example" {
	launch_configuration = "${aws_launch_configuration.example.id}"
	min_size = 0
	max_size = 0
	desired_capacity = 0
	vpc_zone_identifier = ["${data.terraform_remote_state.vpc.public-subnets}"]
	load_balancers = ["${aws_elb.example.name}"]
	health_check_type = "ELB"

	tag {
		key = "Name"
		value = "terraform-asg-example"
		propagate_at_launch = true
	}
}


resource "aws_elb" "example" {
	name = "terraform-asg-name"
	subnets = ["${data.terraform_remote_state.vpc.public-subnets}"]
	security_groups = ["${aws_security_group.elb.id}"]
	listener = {
		lb_port = 80
		lb_protocol = "http"
		instance_port = "${var.server_port}"
		instance_protocol = "http"
	}
}

