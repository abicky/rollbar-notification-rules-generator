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
    message_template     = "template1"
    channel              = "general"
    show_message_buttons = true
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
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
  }
  config {
    message_template     = "template2"
    channel              = "general"
    show_message_buttons = true
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
      type      = "title"
      operation = "nwithin"
      value     = "foo"
    }
  }
  config {
    channel = "random"
  }
}
