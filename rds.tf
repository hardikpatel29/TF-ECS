resource "random_password" "db_master_pass" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
  keepers = {
    pass_version = 1
  }
}

output "db_password" {
  sensitive = true
  value     = random_password.db_master_pass.result

  description = "db password"
}

resource "aws_rds_cluster" "myaurora" {
  cluster_identifier = "aurora-${var.environment}-cluster"
  #availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  engine                       = "aurora-mysql"
  engine_version               = "5.7.mysql_aurora.2.03.2"
  database_name                = var.db_name
  master_username              = var.db_username
  master_password              = var.db_password
  backup_retention_period      = 5
  preferred_backup_window      = "07:00-09:00"
  preferred_maintenance_window = "sun:23:00-mon:00:00"
  vpc_security_group_ids       = [aws_security_group.Prod_RDS_SG.id]
  db_subnet_group_name         = aws_db_subnet_group.aurora_subnet_group.id
  skip_final_snapshot          = true



}

resource "aws_rds_cluster_instance" "myinstance1" {
  apply_immediately   = true
  cluster_identifier  = aws_rds_cluster.myaurora.id
  identifier          = "${var.environment}-aurora-instance"
  instance_class      = "db.t2.small"
  engine              = aws_rds_cluster.myaurora.engine
  engine_version      = aws_rds_cluster.myaurora.engine_version
  publicly_accessible = true
  #preferred_backup_window      = "07:00-09:00"
  #preferred_maintenance_window = "sun:23:00-mon:00:00"
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.id

  tags = {
    Environment = var.environment
    Team        = "Network"
  }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {

  name        = "${var.environment}_aurora_db_subnet_group"
  description = "Allowed subnets for Aurora DB cluster instances"
  subnet_ids  = [aws_subnet.prod_public1.id, aws_subnet.prod_public2.id]

  tags = {

    VPC         = aws_vpc.prodvpc.id
    Environment = var.environment
    Team        = "Network"
  }

}
