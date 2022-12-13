# rollbar-notification-rules-generator

`rollbar-notification-rules-generator` is a CLI tool that generates Rollbar notification rules that are mutually exclusive from a simple YAML file.

Currently, it only outputs rules written in the Terraform language.

## Installation

    $ gem install rollbar-notification-rules-generator

## Usage

```
$ rollbar-notification-rules-generator --help
Usage: rollbar-notification-rules-generator <input>
```

## Examples

See the YAML files in [spec/yaml](spec/yaml). Their output files are in [spec/tf](spec/tf).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `rollbar-notification-rules-generator.gemspec`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abicky/rollbar-notification-rules-generator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
