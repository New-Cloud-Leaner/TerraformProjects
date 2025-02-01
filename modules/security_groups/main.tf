resource "aws_security_group" "sg" {
  for_each = var.security_groups
  vpc_id   = var.vpc_id
  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
      to_port     = ingress.value["to_port"]
      from_port   = ingress.value["from_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
      to_port     = egress.value["to_port"]
      from_port   = egress.value["from_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
  tags = {
    Name = each.key
  }
}
