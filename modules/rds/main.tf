resource "aws_db_subnet_group" "main" {
  name       = "${var.cluster_name}-subnet-group"
  subnet_ids = var.cluster_subnets_id


  tags = {
    Name = "${var.cluster_name}-subnet-group"
  }
}

module "sg" {
  source     = "../vpc/sg"
  depends_on = [aws_db_subnet_group.main]

  vpc_id  = aws_db_subnet_group.main.vpc_id
  name    = "${var.cluster_name}_rds"
  ingress = var.sg_ingress
}

resource "aws_rds_cluster" "main" {
  depends_on = [aws_db_subnet_group.main]

  cluster_identifier     = var.cluster_name
  database_name          = var.cluster_db_name
  master_username        = var.cluster_db_username
  master_password        = var.cluster_db_password
  availability_zones     = var.cluster_availability_zones
  engine                 = var.cluster_engine
  engine_version         = var.cluster_engine_version
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [module.sg.id]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  depends_on = [aws_rds_cluster.main]
  count      = length(var.cluster_availability_zones)

  identifier           = "${var.cluster_name}-${count.index}"
  cluster_identifier   = aws_rds_cluster.main.id
  instance_class       = var.cluster_instance_class
  engine               = aws_rds_cluster.main.engine
  engine_version       = aws_rds_cluster.main.engine_version
  publicly_accessible  = var.cluster_instance_publicly_accessible
  db_subnet_group_name = aws_db_subnet_group.main.name
}
