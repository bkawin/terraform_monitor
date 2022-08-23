resource "google_monitoring_alert_policy" "vm_alerts" {
  for_each   = {
    for index, vm in local.Alerts_config:
    vm.display_name => vm
  }
  display_name = each.value.display_name
  notification_channels = [
    google_monitoring_notification_channel.prodChannel.name,
  ]
  combiner = "OR"
  conditions {
    display_name = format("%s/%s",each.value.display_name,"condition")
    condition_threshold {
      filter = "metric.type=${each.value.metric_type} AND group.id=${local.group_id} AND resource.type=\"gce_instance\""
      duration = var.frequency
      comparison = var.compare
      threshold_value = var.threshold
      aggregations {
        alignment_period = var.alignment
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  documentation {
    content = each.value.doc_content
  }
}

# resource groups

resource "google_monitoring_group" "linuxGroups" {
  display_name = var.group
  filter       = "metadata.user_labels.env=\"prod\""
}

# Notification Channels

resource "google_monitoring_notification_channel" "prodChannel" {
  display_name = var.channel
  type         = "email"
  labels = {
    email_address = var.email
  }
}

