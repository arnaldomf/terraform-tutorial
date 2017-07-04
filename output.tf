output "elb_dns_name" {
	value = "${aws_elb.example.dns_name}"
}

#output "subnets" {
#	value = "${data.aws_subnet_ids.private.ids}"
#}
