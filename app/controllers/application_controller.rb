class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_universe_id

  def run(klass, *args, &block)
    klass.new(self, &block).run(*args)
  end

  def repo
    @repo ||= Repository.new
  end

  def current_universe_id id = nil
    if id.nil? 
      session[:current_universe_id]
    else
      session[:current_universe_id] = id.to_i
    end
  end
  
end
