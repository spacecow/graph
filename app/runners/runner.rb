class Runner

  attr_reader :context
  
  def initialize context
    @context = context
  end

  def repo
    context.repo
  end


end
