# SalsaLabs bindings for Ruby

[![Gem
Version](https://badge.fury.io/rb/salsa_labs.png)](http://badge.fury.io/rb/salsa_labs)
[![Build Status](https://travis-ci.org/VelocityStrategies/ruby-salsa_labs.png?branch=master)](https://travis-ci.org/VelocityStrategies/ruby-salsa_labs)
[![Dependency Status](https://gemnasium.com/VelocityStrategies/ruby-salsa_labs.png)](https://gemnasium.com/VelocityStrategies/ruby-salsa_labs)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/VelocityStrategies/ruby-salsa_labs)

``salsa_labs`` can fetch data from the [Salsa Labs](http://salsalabs.com) API.

## Installation

Add this line to your application's Gemfile:

    gem 'salsa_labs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install salsa_labs

## Usage

By default, you can store your API credentials as the environment variables ``SALSA_LABS_API_EMAIL`` and ``SALSA_LABS_API_PASSWORD`` to avoid the need to re-enter your password multiple times. Otherwise you will need to pass your credentials into the ``SalsaLabs::ApiClient`` or appropriate fetching method as you call it.

You may also specify the sandbox with the environment variable ``SALSA_LABS_API_URL`` or by passing it in the credentials hash. Otherwise, the API URL defaults to ``https://hq-salsa.wiredforchange.com``

``SalsaLabs::ApiClient`` is a general-purpose object for performing GET requests from the Salsa API. 

```ruby
# Create a client
client = SalsaLabs::ApiClient.new({email: 'barry@example.com', password: 'myPassword'})

# Perform arbitrary requests from Salsa API. If not already authenticated, client will do so automatically.
client.fetch('/api/getObjects.sjs', {object: 'Supporter'})
# => Returns XML output of all supporters returned by API.

# Pass filter criteria to #fetch to retrieve a more focused result set.
# Filtering can be necessary if your result set exceeds allowed API limits.
# This query pulls all supporters with an address in Washington, D.C.
client.fetch('/api/getObjects.sjs', {object: 'Supporter', State: 'DC'})
```

You can get a list of API calls and information about Salsa database objects here:
[https://help.salsalabs.com/entries/23537918-Getting-data-from-Salsa](https://help.salsalabs.com/entries/23537918-Getting-data-from-Salsa)

Currently specific functionality exists to work with Action campaigns and Supporters. More objects will be added later.

```ruby
# Fetch all actions from Salsa. First argument is filter criteria, second argument is credentials if you are not storing them as environment variables.
actions = SalsaLabs::Action.fetch({}, {})
# => Array of SalsaLabs::Action objects.

# Examine the Action.
actions.first.attributes
# => {"action_key"=>"12345", "organization_key"=>"90210", "title"=>"My Action Title" ...}
```

```ruby
# Fetch all supporters from Salsa. First argument is filter criteria, second argument is credentials if you are not storing them as environment variables.
supporters = SalsaLabs::Supporter.fetch({}, {})
# => Array of SalsaLabs::Supporter objects.

# Examine the Supporter.
supporters.first.attributes
# => {"supporter_key"=>"12345", "organization_key"=>"90210", "first_name"=>"John", "mi"=>"Jacob", "last_name"=>"Jingleheimer Schmidt" ...}
```

``SalsaLabs::Object#attributes`` returns a hash corresponding to all the attributes returned by the API, so it should accommodate custom fields and/or new fields added later by SalsaLabs. All attribute names are downcased. 

## Dependencies

Ruby 1.9 is required.

## Credits

The ``salsa_labs`` gem was created and is maintained by [Allison Sheren](http://github.com/asheren) and [Geoff Harcourt](http://github.com/geoffharcourt).

Development is generously sponsored by [Velocity](http://wearevelocity.com), in support of their work with progressive organizations.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The ``salsa_labs`` gem is Copyright 2013-2014 Velocity. It is free software, and
may be redistributed under the terms of the MIT license, specified in the 
LICENSE file.
