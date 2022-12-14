resource "rollbar_notification" "slack_new_item_0" {
  provider = rollbar.alias_value

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
