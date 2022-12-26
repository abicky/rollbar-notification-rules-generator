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
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "within"
      value     = "bar"
    }
  }
  config {
    channel = "foo-and-bar"
  }
}

resource "rollbar_notification" "slack_new_item_1" {
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
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nwithin"
      value     = "bar"
    }
  }
  config {
    channel = "foo"
  }
}

resource "rollbar_notification" "slack_new_item_2" {
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
      operation = "nwithin"
      value     = "foo"
    }
  }
}
