resource "google_monitoring_alert_policy" "sql_alerts" {
  #project = var.project
  for_each   = {
    for index, sql in local.Alerts_config:
    sql.display_name => sql
  }
  
  display_name          = each.value.display_name
  combiner              = "OR"
  notification_channels = [
    google_monitoring_notification_channel.sqlChannel.name,
  ]
  conditions {
    display_name = format("%s/%s",each.value.display_name,"condition")
    condition_threshold {
#      filter          = "metric.type=\"cloudsql.googleapis.com/database/auto_failover_request_count\" AND resource.type=\"cloudsql_database\" AND resource.label.database_id=\"cloudasset-358015:test\" AND metadata.user_labels.env=\"prod\""
      
      filter = "metric.type=${each.value.metric_type} AND group.id=${local.group_id} AND resource.type=\"cloudsql_database\" AND resource.label.database_id=\"var.gcp_project:var.dbname\" AND metadata.user_labels.env=\"dev\""
      duration = var.frequency
      comparison = var.compare
      threshold_value = var.threshold
      trigger {
        count = "var.triggercount"
      }
      aggregations {
        alignment_period     = "alignment"
        per_series_aligner   = "ALIGN_MEAN"
        group_by_fields      = ["resource.label.database_id", "resource.label.project_id", ]
      }
    }
  }
  
  # resource groups

resource "google_monitoring_group" "sqlGroups" {
  display_name = var.group
  filter       = "metadata.user_labels.env=\"dev\""
}

# Notification Channels

resource "google_monitoring_notification_channel" "sqlChannel" {
  display_name = var.channel
  type         = "email"
  labels = {
    email_address = var.email
  }
}
