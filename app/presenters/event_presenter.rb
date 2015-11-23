class EventPresenter

  #TODO base presenter
  def initialize object, template
    @object = object
    @template = template
  end

  def parent
    @object.parent.try(:title)
  end

end
