resource "rollbar_notification" "slack_new_item_0" {
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

resource "rollbar_notification" "slack_deploy_0" {
  channel = "slack"

  rule {
    trigger = "deploy"
    filters {
      type      = "environment"
      operation = "eq"
      value     = "production"
    }
  }
}

resource "rollbar_notification" "slack_reactivated_item_0" {
  channel = "slack"

  rule {
    trigger = "reactivated_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}

resource "rollbar_notification" "slack_reopened_item_0" {
  channel = "slack"

  rule {
    trigger = "reopened_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}

resource "rollbar_notification" "slack_occurrence_rate_0" {
  channel = "slack"

  rule {
    trigger = "occurrence_rate"
    filters {
      type   = "rate"
      count  = 10
      period = 300
    }
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}

resource "rollbar_notification" "slack_exp_repeat_item_0" {
  channel = "slack"

  rule {
    trigger = "exp_repeat_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}

resource "rollbar_notification" "slack_resolved_item_0" {
  channel = "slack"

  rule {
    trigger = "resolved_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
  }
}

resource "rollbar_notification" "slack_occurrence_0" {
  channel = "slack"

  rule {
    trigger = "occurrence"
    filters {
      type      = "title"
      operation = "within"
      value     = "Your rate limit has been reached"
    }
    filters {
      type      = "framework"
      operation = "eq"
      value     = "System Message"
    }
  }
}

resource "rollbar_notification" "slack_occurrence_1" {
  channel = "slack"

  rule {
    trigger = "occurrence"
    filters {
      type      = "title"
      operation = "within"
      value     = "The system rate limit of"
    }
    filters {
      type      = "framework"
      operation = "eq"
      value     = "System Message"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "Your rate limit has been reached"
    }
  }
}
