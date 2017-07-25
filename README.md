# Rails Warden


This application adds some nice helpers on-top of the base [Warden](https://github.com/hassox/warden) Rack layer. It aims to make Warden easier to use in Rails-based environments without something as heavy-weight as devise.

Require the gem:

```ruby
gem 'rails_warden'
```

Setup an initializer:

```ruby
# config/initializers/warden.rb

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :my_strategy
  manager.failure_app = LoginController
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    [record.class.name, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    klass.find(:first, :conditions => { :id => id })
  end
end

# Declare your strategies here, or require a file that defines one.
#Warden::Strategies.add(:my_strategy) do
#  def authenticate!
#    # do stuff
#  end
#end
  
```
