provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "medusa-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_dns_hostnames = true
}

module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "4.1.3"

  cluster_name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "medusa-backend",
      image     = var.image_url,
      portMappings = [{ containerPort = 9000, hostPort = 9000 }],
      environment = [
        { name = "NODE_ENV", value = "production" },
        { name = "DATABASE_URL", value = var.database_url }
      ]
    }
  ])
}

resource "aws_ecs_service" "medusa" {
  name            = "medusa-service"
  cluster         = module.ecs_cluster.cluster_id
  task_definition = aws_ecs_task_definition.medusa.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = module.vpc.public_subnets
    assign_public_ip = true
    security_groups = [aws_security_group.ecs_sg.id]
  }
}
