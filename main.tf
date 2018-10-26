# Manage Route 53 alias record.

resource "aws_route53_record" "default" {
  # Zone and name of Route53 record being managed.
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.hostname}"
  type    = "A"

  alias {
    # Target of Route53 alias.
    name                   = "${data.aws_lb.selected.dns_name}"
    zone_id                = "${data.aws_lb.selected.zone_id}"
    evaluate_target_health = "true"
  }
}
