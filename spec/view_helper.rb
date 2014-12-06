require 'rspec/its'
require 'pry'

class ErbBinding
  def initialize(hash)
    hash.each do |key, value|
      singleton_class.send(:define_method,key){ value }
    end
  end
  def get_bindings; binding end
end

module ErbHelper
end

def rendering; @erb.result @local_bindings end

def render_view(file:nil, locals:{}, helper:nil)
  filepath = File.expand_path "../../app/views/#{file}", __FILE__
  erb_binding = ErbBinding.
    new(locals).
    extend(ErbHelper)
  erb_binding = erb_binding.extend(helper) unless helper.nil?
  @local_bindings = erb_binding.instance_eval{binding}
  @erb = ERB.new File.read(filepath)
end
