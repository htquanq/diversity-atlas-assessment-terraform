resource "aws_vpc_peering_connection" "main" {
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  peer_owner_id = var.peer_owner_id
  auto_accept   = var.auto_accept
  peer_region   = var.auto_accept == false ? var.peer_region : null
  tags          = var.tags
  dynamic "accepter" {
    for_each = length(var.accepter) > 0 ? [var.accepter] : []
    content {
      allow_remote_vpc_dns_resolution  = lookup(accepter.value, "allow_remote_vpc_dns_resolution", false)
      allow_classic_link_to_remote_vpc = lookup(accepter.value, "allow_classic_link_to_remote_vpc", false)
      allow_vpc_to_remote_classic_link = lookup(accepter.value, "allow_vpc_to_remote_classic_link", false)
    }
  }

  dynamic "requester" {
    for_each = length(var.requester) > 0 ? [var.requester] : []
    content {
      allow_remote_vpc_dns_resolution  = lookup(requester.value, "allow_remote_vpc_dns_resolution", false)
      allow_classic_link_to_remote_vpc = lookup(requester.value, "allow_classic_link_to_remote_vpc", false)
      allow_vpc_to_remote_classic_link = lookup(requester.value, "allow_vpc_to_remote_classic_link", false)
    }
  }
}