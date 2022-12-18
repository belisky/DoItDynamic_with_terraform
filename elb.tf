# Create a new load balancer
resource "aws_lb" "nobel_lb" {
  name               = "nobel-lb"
  internal =false
  load_balancer_type = "application"
 
  subnets = "${aws_subnet.nobel_public_sn.*.id}"
  security_groups = ["${aws_security_group.nobel_webservers.id}"]
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nobel_lb.arn
  port              = "80"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nobel_tg.arn
  }
}

output "elb-dns-name" {
  value = aws_lb.nobel_lb.dns_name
}

resource "aws_lb_target_group" "nobel_tg" {
  name     = "tf-nobel-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.nobel_vpc_1.id
}
resource "aws_lb_target_group_attachment" "nobel_tg_attach" {
  count = "${length(var.subnet_cidrs_public)}" 
  target_group_arn = aws_lb_target_group.nobel_tg.arn
  target_id        = "${element(aws_instance.nobel_webservers.*.id,count.index)}"
  port             = 80
}
resource "aws_lb_listener_certificate" "example" {
  listener_arn    = aws_lb_listener.front_end.arn
  certificate_arn = aws_acm_certificate.cert.arn
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "example.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}