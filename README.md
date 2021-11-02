![workflow](https://github.com/bloodbath-io/bloodbath-ruby/actions/workflows/main.yml/badge.svg)
![website](https://img.shields.io/website.svg?down_color=red&down_message=down&up_color=purple&up_message=up&url=http%3A%2F%2Fbloodbath.io)
[![GitHub release](https://img.shields.io/github/release/bloodbath-io/bloodbath-ruby.svg)](https://github.com/bloodbath-io/bloodbath-ruby/releases/)
![](https://ruby-gem-downloads-badge.herokuapp.com/bloodbath?type=total)


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

For more documentation about how to use Bloodbath, don't hesitate to check [Bloodbath Docs](https://docs.bloodbath.io).

## Advanced usage
### Multi-threads

If you want to schedule a lot of events at once, waiting for the response might be too slow, that's why we developped a multi-thread scheduling option for the Ruby library.

```ruby
Bloodbath::Event.new(wait_for_response: false).schedule(
  scheduled_for: Time.now + 60 * 60 + 5,
  headers: {},
  method: :post,
  body: "some body content",
  endpoint: 'https://api.acme.com/path'
)
```

With this option, it'll schedule your events ~10 times faster, but you won't be able to receive the response directly. Instead, it'll return the spawned threads.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bloodbath-io/bloodbath-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bloodbath-io/bloodbath-ruby/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Bloodbath project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bloodbath-io/bloodbath-ruby/blob/master/CODE_OF_CONDUCT.md).
