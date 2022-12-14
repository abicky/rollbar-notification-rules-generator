resource "rollbar_notification" "pagerduty_exp_repeat_item_0" {
  channel = "pagerduty"

  rule {
    trigger = "exp_repeat_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}

resource "rollbar_notification" "pagerduty_reactivated_item_0" {
  channel = "pagerduty"

  rule {
    trigger = "reactivated_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}

resource "rollbar_notification" "pagerduty_resolved_item_0" {
  channel = "pagerduty"

  rule {
    trigger = "resolved_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}
