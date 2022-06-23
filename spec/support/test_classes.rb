# frozen_string_literal: true

class FooFailure
end

class FooUser
end

class User
end

class MockController < ActionController::Base
  include RailsWarden::Authentication
  attr_accessor :env
  def request
    self
  end
end
