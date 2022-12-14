resource "rollbar_notification" "slack_new_item_0" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "gte"
      value     = "error"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "foo"
    }
  }
  config {
    channel = "foo"
  }
}

resource "rollbar_notification" "slack_new_item_1" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
  }
  config {
    channel = "bar"
  }
}

resource "rollbar_notification" "slack_new_item_2" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "error"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "baz"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
  }
  config {
    channel = "baz"
  }
}

resource "rollbar_notification" "slack_new_item_3" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "baz"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "bar"
    }
  }
  config {
    channel = "baz"
  }
}

resource "rollbar_notification" "slack_new_item_4" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "warning"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "qux"
    }
  }
  config {
    channel = "qux"
  }
}

resource "rollbar_notification" "slack_new_item_5" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "warning"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "qux"
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_6" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "error"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "baz"
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_7" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "bar"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "baz"
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_8" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "title"
      operation = "within"
      value     = "corge"
    }
    filters {
      type      = "level"
      operation = "eq"
      value     = "debug"
    }
  }
  config {
    channel = "corge"
  }
}

resource "rollbar_notification" "slack_new_item_9" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "title"
      operation = "within"
      value     = "corge"
    }
    filters {
      type      = "level"
      operation = "eq"
      value     = "info"
    }
  }
  config {
    channel = "corge"
  }
}

resource "rollbar_notification" "slack_new_item_10" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "title"
      operation = "within"
      value     = "corge"
    }
    filters {
      type      = "level"
      operation = "eq"
      value     = "warning"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "qux"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "quux"
    }
  }
  config {
    channel = "corge"
  }
}

resource "rollbar_notification" "slack_new_item_11" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "title"
      operation = "within"
      value     = "corge"
    }
    filters {
      type      = "level"
      operation = "eq"
      value     = "error"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "baz"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "quux"
    }
  }
  config {
    channel = "corge"
  }
}

resource "rollbar_notification" "slack_new_item_12" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "title"
      operation = "within"
      value     = "corge"
    }
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "bar"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "baz"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "quux"
    }
  }
  config {
    channel = "corge"
  }
}
