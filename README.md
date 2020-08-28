# Croaky::Rspec

[![Gem Version](https://badge.fury.io/rb/croaky-rspec.svg)](https://badge.fury.io/rb/croaky-rspec)
[![Build Status](https://travis-ci.org/sayantam/croaky-rspec.svg?branch=master)](https://travis-ci.org/sayantam/croaky-rspec)

RSpec 3.0 formatter that croaks only for failed examples. The formatter captures stdout and stderr during an example
run, and dumps them for failed examples only. Progress is shown as per progress formatter.

It detects a JRuby platform and captures output from Java as well. For example, it will capture console output from a
logger like ``log4j``, as well as Java IO streams such as ``java.lang.System.out``, and ``java.lang.System.err``.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'croaky-rspec'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install croaky-rspec

## Usage

This is meant to be an RSpec >= 3.0 formatter. The fully qualified class name is ``Croaky::RSpec::CroakyFormatter``.
Use RSpec's ``format`` option to specify this formatter.

```bash
$ bundle exec rspec -f Croaky::RSpec::CroakyFormatter
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version,
update the version number in `version.rb`, and then push to origin master. This will trigger a CI flow, that
will run the specs, and upon success, it will release a new gem to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sayantam/croaky-rspec. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/[USERNAME]/croaky-rspec/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Croaky::Rspec project's codebases, issue trackers, chat rooms and mailing lists is
expected to follow the [code of conduct](https://github.com/[USERNAME]/croaky-rspec/blob/master/CODE_OF_CONDUCT.md).
