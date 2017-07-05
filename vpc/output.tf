output "public-subnets" {
	value = ["${aws_subnet.public-1a.id}", "${aws_subnet.public-1b.id}"]
}
output "private-subnets" {
	value = ["${aws_subnet.private-1a.id}", "${aws_subnet.private-1b.id}"]
}
output "vpc_id" {
	value = "${aws_vpc.terraform.id}"
}
