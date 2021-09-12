![workflow](https://github.com/bloodbath-io/bloodbath-ruby/actions/workflows/main.yml/badge.svg)

# Bloodbath Ruby Library

The Bloodbath Ruby library provides convenient access to the Bloodbath API from applications written in the Ruby language.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bloodbath'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bloodbath

## Usage

### Configuration
The library needs to be configured with your account's API key which is available in your [Bloodbath Dashboard](https://app.bloodbath.io/). Set `Bloodbath.api_key` to its value:

```ruby
require 'bloodbath'
Bloodbath.api_key = 'NTI6PASMD9BQhYtRh...'
```

#### Events
```ruby
# schedule an event
Bloodbath::Event.schedule(
  scheduled_for: Time.now + 60 * 60 + 5,
  headers: {},
  method: :post,
  body: "some body content",
  endpoint: 'https://api.acme.com/path'
)

# list events
Bloodbath::Event.list()

# find an event
Bloodbath::Event.find('b7ccff...')

# cancel an event
Bloodbath::Event.cancel('b7ccff...')
```

For more documentation about how to use Bloodbath, don't hesitate to check [Bloodbath Docs](https://bloodbath.notion.site/Guide-00a3edc8f43b4528b2e34bf5eac5b0df).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bloodbath-io/bloodbath-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bloodbath-io/bloodbath-ruby/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Bloodbath project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bloodbath-io/bloodbath-ruby/blob/master/CODE_OF_CONDUCT.md).
