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
}
