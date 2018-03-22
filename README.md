# Rails Warden

This application adds some nice helpers on-top of the base [Warden](https://github.com/hassox/warden) Rack layer. It aims to make Warden easier to use in Rails-based environments without something as heavy-weight as devise.

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
  manager.default_strategies :my_strategy
  manager.failure_app = LoginController
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

The next step is to configure warden with some authentication strategies. Check out the [warden wiki](https://github.com/hassox/warden/wiki/Strategies) for that.

### Application Mixin

RailsWarden ships with a helpful set of methods and helpers for use inside of ActionController.

To use them, just include them inside your base controller.

```ruby
class ApplicationController < ActionController::Base
  include RailsWarden::Authentication
end
```