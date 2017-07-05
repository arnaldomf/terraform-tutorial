data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "terraform_remote_state" "vpc" {
	backend = "local"
	config {
		path = "../vpc/terraform.tfstate"
	}
}

data "template_file" "user-data" {
	template = "${file("user-data.sh")}"
	vars {
		server_port = "${var.server_port}"
	}
}
