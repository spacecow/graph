class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def run(klass, *args, &block)
    klass.new(self, &block).run(*args)
  end

  def repo
    @repo ||= GraphRepository.new
  end

end
