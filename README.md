# Rails Warden

[![CircleCI](https://circleci.com/gh/wardencommunity/rails_warden.svg?style=svg)](https://circleci.com/gh/wardencommunity/rails_warden)

This application adds some nice helpers on-top of the base [Warden](https://github.com/wardencommunity/warden) Rack layer. It aims to make Warden easier to use in Rails-based environments without something as heavy-weight as devise.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_warden'
```

And then execute

```
$ bundle
```

Or install it yourself as:

```
$ gem install rails_warden
```

## Usage

Create a new Rails initializer to inject RailsWarden into the Rails middleware stack:

```ruby
# config/initializers/warden.rb
Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.failure_app = Proc.new { |_env|
    ['401', {'Content-Type' => 'application/json'}, { error: 'Unauthorized', code: 401 }]
  }
  manager.default_strategies :password # needs to be defined
  # Optional Settings (see Warden wiki)
  # manager.scope_defaults :admin, strategies: [:password]
  # manager.default_scope = :admin # optional default scope
  # manager.intercept_401 = false # Warden will intercept 401 responses, which can cause conflicts
end
```

If you want to customize the Session serializer (optional), add the following to the intializer:

```ruby
class Warden::SessionSerializer
  def serialize(record)
    [record.class.name, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    klass.find_by(id: id)
  end
end
```

The next step is to configure warden with some authentication strategies. Check out the [warden wiki](https://github.com/wardencommunity/warden/wiki/Strategies) for that.

### Application Mixin

RailsWarden ships with a helpful set of methods and helpers for use inside of ActionController.

To use them, just include them inside your base controller.

```ruby
class ApplicationController < ActionController::Base
  include RailsWarden::Authentication
end
```