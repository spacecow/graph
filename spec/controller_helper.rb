module ActionController
  class Base
    def self.protect_from_forgery s; end
  end
end unless defined?(ActionController)

require './app/controllers/application_controller'
