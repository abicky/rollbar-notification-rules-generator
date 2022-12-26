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
      operation = "eq"
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
      operation = "eq"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "neq"
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
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "eq"
      value     = "baz"
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
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "eq"
      value     = "baz"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "neq"
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
      type      = "path"
      path      = "body.body.trace.extra.c"
      operation = "eq"
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
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "eq"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.c"
      operation = "neq"
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
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "eq"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "neq"
      value     = "foo"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "neq"
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
      type      = "path"
      path      = "body.body.trace.extra.d"
      operation = "eq"
      value     = "quux"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "neq"
      value     = "foo"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "neq"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "neq"
      value     = "baz"
    }
  }
  config {
    channel = "quux"
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
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "eq"
      value     = "foo"
    }
  }
  config {
    channel = "foo"
  }
}

resource "rollbar_notification" "slack_occurrence_rate_1" {
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
      operation = "eq"
      value     = "critical"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "eq"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "neq"
      value     = "foo"
    }
  }
  config {
    channel = "bar"
  }
}
