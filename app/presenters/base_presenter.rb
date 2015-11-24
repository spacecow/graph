class BasePresenter

  def initialize object, template
    @object = object
    @template = template
  end

  private
  
    def h; @template end

    def self.presents name
      define_method(name){ @object }
    end

end
