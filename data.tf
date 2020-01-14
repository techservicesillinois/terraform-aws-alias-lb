# Find specified load balancer in order to retrieve dns_name and zone_id
# attributes of target ALB.

data "aws_lb" "selected" {
  name = var.lb_name
}

# Find Route 53 zone specified by domain variable in order to retrieve
# zone_id attribute of zone in which alias record is being managed.

data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = data.aws_lb.selected.internal
  vpc_id       = data.aws_lb.selected.internal ? data.aws_lb.selected.vpc_id : ""
}
