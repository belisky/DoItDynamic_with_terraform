resource "aws_instance" "nobel_webservers" {
  count = "${length(var.subnet_cidrs_public)}"
  instance_type="${var.instance_type}"
  ami = "${var.webservers_ami}"
 
  security_groups = ["${aws_security_group.nobel_webservers.id}"]
  subnet_id = "${element(aws_subnet.nobel_public_sn.*.id,count.index)}"
  user_data = "${file("install_docker.sh")}"

	tags = var.tags
}
 