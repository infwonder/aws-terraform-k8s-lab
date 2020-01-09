resource "aws_route53_record" "k8smaster" {
  zone_id = var.AWS_ROUTE53_ZONEID_K8S
  name    = "k8smaster.k8s.11be.org"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.terra01.public_ip]
}

resource "aws_route53_record" "k8snode01" {
  zone_id = var.AWS_ROUTE53_ZONEID_K8S
  name    = "k8snode01.k8s.11be.org"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.terra02.public_ip]
}

resource "aws_route53_record" "k8snode02" {
  zone_id = var.AWS_ROUTE53_ZONEID_K8S
  name    = "k8snode02.k8s.11be.org"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.terra03.public_ip]
}
