module ActionController
  class Base
    def self.protect_from_forgery s; end
    def self.helper_method s; end
  end
end unless defined?(ActionController)

require './app/controllers/application_controller'
