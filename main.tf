terraform {
  cloud {
    organization = "hashicorp-matthew"

    workspaces {
      name = "lock-test"
    }
  }
}

# This resource will destroy (potentially immediately) after null_resource.next
resource "null_resource" "previous" {}

resource "time_sleep" "wait_60_minutes" {
  depends_on = [null_resource.previous]

  create_duration = "60m"
}

# This resource will create (at least) 60 minutes after null_resource.previous
resource "null_resource" "next" {
  depends_on = [time_sleep.wait_60_minutes]
}
