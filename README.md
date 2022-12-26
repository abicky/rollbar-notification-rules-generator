# rollbar-notification-rules-generator

`rollbar-notification-rules-generator` is a CLI tool that generates Rollbar notification rules
that are mutually exclusive from a simple YAML file.
If you outputs the rules in the Terraform language, you can create the rules with Terraform.

For example, assume that you want to notify errors whose title contains the substring "foo"
to the Slack channel "alert-foo" every time they occur and other errors to the default channel.
You can write the Rollbar notification rules in the Terraform language as follows:

```terraform
resource "rollbar_notification" "slack_occurrence_0" {
  channel = "slack"

  rule {
    trigger = "occurrence"
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
    channel = "alert-foo"
  }
}

resource "rollbar_notification" "slack_occurrence_1" {
  channel = "slack"

  rule {
    trigger = "occurrence"
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
  }
}
```

As you can see, you have to add the filter whose operation is "nwithin" to the second rule.
If there are more rules, you have to write complicated rules to make them mutually exclusive
and struggle to maintain them.
With this tool, you can write the rules in YAML format as follows:

```yaml
channel: "slack"
triggers:
  occurrence:
    - conditions:
        - type: "level"
          operation: "gte"
          value: "error"
        - type: "title"
          operation: "within"
          value: "foo"
      configs:
        - channel: "alert-foo"
    - conditions:
        - type: "level"
          operation: "gte"
          value: "error"
```

You don't have to add another condition to the second rule because the tool generates rules
to make Rollbar behave as if it tries to find the first rule from the top down that matches
all the conditions.

## Installation

    $ gem install rollbar-notification-rules-generator

## Usage

```
Usage: rollbar-notification-rules-generator [options] <input>
        --format FORMAT              terraform|text (default: terraform)
```

The input file is in YAML format like the following:

```yaml
channel: "slack" # slack or pagerduty
# This optional value is used as the namespace of Terraform resources.
terraform_provider: foo_
# This optional value is used as provider meta-argument of Terraform.
terraform_provider: rollbar.alias_value
# You can define variables, and they are expanded with the syntax "${{ var.variable_name }}".
variables:
  slack_channel_for_foo: "alert-foo"
triggers:
  # You can specify the following triggers:
  #   * new_item
  #   * deploy
  #   * reactivated_item
  #   * reopened_item
  #   * occurrence_rate
  #   * exp_repeat_item
  #   * resolved_item
  #   * occurrence
  occurrence:
    # Each element corresponds to a Rollbar notification rule.
    # For more details, the following documents help:
    #  * https://docs.rollbar.com/reference/post_api-1-notifications-slack-rules
    #  * https://docs.rollbar.com/reference/post_api-1-notifications-pagerduty
    #  * https://registry.terraform.io/providers/rollbar/rollbar/latest/docs/resources/notification
    # Note that the tool hasn't supported some types yet.
    - conditions:
        - type: "level"
          operation: "gte"
          value: "error"
        - type: "title"
          operation: "within"
          value: "foo"
      # Each element corresponds to "config."
      # If you specify multiple elements, as many rules as the elements are created,
      # and Rollbar notifies items according to each configuration.
      configs:
        - channel: ${{ var.slack_channel_for_foo }}
    - conditions:
        - type: "level"
          operation: "gte"
          value: "error"
```

The text format makes it easier to read the generated rules as follows:

```
# Slack
## Every Occurrence
### Rule 0
conditions:
  level >= error
  title contains substring "foo"

config:
    channel = "alert-foo"

### Rule 1
conditions:
  level >= error
  title does not contain substring "foo"
```

## Examples

See the YAML files in [spec/files/yaml](spec/files/yaml). Their output files are in [spec/files/tf](spec/files/tf) and [spec/files/txt](spec/files/txt).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `exe/rollbar-notification-rules-generator`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abicky/rollbar-notification-rules-generator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
