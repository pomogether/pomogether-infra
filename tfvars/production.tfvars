region  = "us-east-1"

vpc_cidr_block = "10.0.0.0/16"

route_table_config = {
  public = {
    name       = "public-pomogether-us-east-1a"
    cidr_block = "0.0.0.0/0"
  }
  routes = [
    {
      name = "private-pomogether-us-east-1a"
    }
  ]
}
subnet_config = [
  {
    cidr_block  = "10.0.0.0/24"
    az          = "us-east-1a"
    route_table = "public-pomogether-us-east-1a"
  },
  {
    cidr_block  = "10.0.1.0/24"
    az          = "us-east-1a"
    route_table = "private-pomogether-us-east-1a"
  }
]
