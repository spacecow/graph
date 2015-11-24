class UniversePresenter < BasePresenter
  
  def clazz selected
    "universe#{selected ? ' selected' : ''}"
  end

end
