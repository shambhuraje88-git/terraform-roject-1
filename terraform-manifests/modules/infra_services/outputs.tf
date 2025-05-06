resource "aws_security_group" "terraform_test_sg" {
  name        = "${var.cloud_env}_terraform_test_sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.terraform_test_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.access_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cloud_env}_terraform_test_sg"
  }
}










#output "security_group_id" {
 # value       = aws_security_group.terraform_test_sg.id
  #description = "Security Group ID"
#}

// You can access module output variables using the following syntax:
// module.<MODULE_NAME>.<OUTPUT_NAME>
// module.infra_services_module.instance_arn
