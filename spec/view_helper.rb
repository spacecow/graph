require 'rspec/its'
require 'pry'
require 'assert'
require 'capybara'

class ErbBinding
  def initialize(hash)
    hash.each do |key, value|
      singleton_class.send(:define_method,key){ value }
    end
  end
  def link_to link, path; "<a href='#{path}'>#{link}</a>" end
  def get_bindings; binding end
end
