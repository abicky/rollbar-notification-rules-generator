resource "rollbar_notification" "foo_slack_new_item_0" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}
