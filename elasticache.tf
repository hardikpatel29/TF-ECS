resource "aws_elasticache_subnet_group" "dev" {
  name       = "${var.environment}-dev"
  subnet_ids = [aws_subnet.prod_public1.id, aws_subnet.prod_public2.id]
}


resource "aws_elasticache_replication_group" "elasticache-cluster" {
  replication_group_id          = "${var.environment}-redis-cluster"
  replication_group_description = "${var.environment} description"
  engine                        = "redis"
  node_type                     = "cache.t3.small"
  port                          = 6379
  parameter_group_name          = "default.redis6.x.cluster.on"
  automatic_failover_enabled    = true
  engine_version                = "6.x"

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 2
  }

  maintenance_window       = "sun:23:00-mon:00:00"
  security_group_ids       = [aws_security_group.Prod_ecsSG.id]
  snapshot_window          = "20:30-21:30"
  snapshot_retention_limit = "3"
  subnet_group_name        = aws_elasticache_subnet_group.dev.name
  #security_group_names          = "test"
  apply_immediately = false

  tags = {
    Environment = var.environment
    Team        = "Network"
  }
}