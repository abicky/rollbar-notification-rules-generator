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
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "within"
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
      operation = "gte"
      value     = "error"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "title"
      operation = "nwithin"
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
      operation = "gte"
      value     = "error"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "foo"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
    }
  }
}

resource "rollbar_notification" "slack_new_item_3" {
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
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "nwithin"
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
      operation = "gte"
      value     = "error"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nwithin"
      value     = "bar"
    }
  }
}

resource "rollbar_notification" "slack_new_item_5" {
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
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "nwithin"
      value     = "bar"
    }
  }
}

resource "rollbar_notification" "slack_new_item_6" {
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
    filters {
      type      = "path"
      path      = "body.body.trace.extra.a"
      operation = "nwithin"
      value     = "foo"
    }
    filters {
      type      = "title"
      operation = "within"
      value     = "bar"
    }
    filters {
      type      = "path"
      path      = "body.body.trace.extra.b"
      operation = "nwithin"
      value     = "bar"
    }
  }
}
