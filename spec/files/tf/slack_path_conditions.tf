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
      type      = "path"
      path      = "body.body.trace.extra.a"
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
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
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
      value     = "critical"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nexists"
      value     = ""
    }
  }
  config {
    channel = "bar"
  }
}

resource "rollbar_notification" "slack_new_item_3" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "error"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "within"
      value     = "baz"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
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
      value     = "critical"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "within"
      value     = "baz"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nwithin"
      value     = "bar"
    }
  }
  config {
    channel = "baz"
  }
}

resource "rollbar_notification" "slack_new_item_5" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "within"
      value     = "baz"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nexists"
      value     = ""
    }
  }
  config {
    channel = "baz"
  }
}

resource "rollbar_notification" "slack_new_item_6" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "warning"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.c"
      operation = "within"
      value     = "qux"
    }
  }
  config {
    channel = "qux"
  }
}

resource "rollbar_notification" "slack_new_item_7" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "warning"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.c"
      operation = "nwithin"
      value     = "qux"
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
      type      = "level"
      operation = "eq"
      value     = "warning"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.c"
      operation = "nexists"
      value     = ""
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_9" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "error"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "baz"
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_10" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "error"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nexists"
      value     = ""
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_11" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nwithin"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "baz"
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_12" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nexists"
      value     = ""
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "baz"
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_13" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nexists"
      value     = ""
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nwithin"
      value     = "bar"
    }
  }
  config {
    channel = "quux"
  }
}

resource "rollbar_notification" "slack_new_item_14" {
  channel = "slack"

  rule {
    trigger = "new_item"
    filters {
      type      = "level"
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "within"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nexists"
      value     = ""
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nexists"
      value     = ""
    }
  }
  config {
    channel = "quux"
  }
}
