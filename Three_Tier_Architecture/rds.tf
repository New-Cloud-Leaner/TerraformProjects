resource "aws_db_subnet_group" "rds_subnet_grp" {
  name       = "three-tier-rds-subnet-grp"
  subnet_ids = aws_subnet.private_subnet[*].id
  tags = {
    Name = "three-tier-rds-subnet-grp"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_user
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_grp.name
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  tags = {
    Name = "three-tier-rds"
  }
}