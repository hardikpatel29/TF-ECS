
#cidr_block = ""
region = "us-east-1"

bucket_name_prefix = {
  prod = "prodinsura",
  stag = "staginsura",
  test = "testinsura"
}

domain = {
  admin = "admin.local",
  agent = "agent.local",
  api   = "api.local"
}

container_image = {
  frontend  = "ecr-frontend-admin-repo",
  frontend1 = "ecr-frontend-agent-repo",
  backend   = "ecr-backend-api-repo"
}


container_cpu    = "256"
container_memory = "512"
task_definition_name = {
  frontend  = "admin",
  frontend1 = "agent",
  backend   = "api"
}

container_port = {
  frontend  = "8000",
  frontend1 = "80",
  backend   = "8000"
}

container_insight_status = {
  enable  = "enabled",
  disable = "disabled"
}

ecs_service_launch_type = {
  fargate = "FARGATE",
  ec2     = "EC2"
}

ecs_service_strategy = {
  replica = "REPLICA",
  daemon  = "DAEMON"
}

ecs_service_desired_count = {
  frontend  = "1",
  frontend1 = "1",
  backend   = "1"
}

ecr_tag = {
  latest = "latest",
  dev    = "dev"
}

ecs_service_max_capacity = "2"
ecs_service_min_capacity = "1"
adjustment_type = {
  changein        = "ChangeInCapacity",
  exact           = "ExactCapacity",
  percentchangein = "PercentChangeInCapacity"
}

metric_aggregation_type = {

  min = "Minimum",
  max = "Maximum",
  avg = "Average"

}

scale_up_alarm = {
  frontend  = "frontend-scale-up",
  backend   = "backend-scale-up",
  frontend1 = "frontend1-scale-up"
}
scale_down_alarm = {
  frontend  = "frontend-scale-down",
  backend   = "backend-scale-down",
  frontend1 = "frontend1-scale-down"
}

db_username = "admin"
db_password = "4PJDvsqG3M4U6haA"
db_name     = "mydemo"

//mine
aws_access_key = "AKIA2B2ZF5KSBB7TZM5D"
aws_secret_key = "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"

alb_tls_cert_arn       = "arn:aws:acm:us-east-1:691139898020:certificate/79daa77d-9ca2-443f-95f3-f11216c6757d"
ECS_Service_Scale_Role = "arn:aws:iam::691139898020:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
