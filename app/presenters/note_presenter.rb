class NotePresenter

  def initialize object, template
    @object = object
    @template = template
  end

  def tags
    @object.tags.map(&:title).join(', ')
  end

end
