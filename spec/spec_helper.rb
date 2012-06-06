$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'rails/version'

if Rails::VERSION::MAJOR > 2
  require 'rails'
else
  module Rails
    class FakeConfig
      def after_initialize
      end
    end
    @@configuration = FakeConfig.new
  end
  require 'initializer'
end
require 'rails_warden'
