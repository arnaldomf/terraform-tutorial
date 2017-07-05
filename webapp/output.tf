output "elb_dns" {
	value = "${aws_elb.example.dns_name}"
}
output "user_data" {
	value ="${data.template_file.user-data.rendered}"
}
