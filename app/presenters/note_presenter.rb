class NotePresenter

  def initialize object, template
    @object = object
    @template = template
  end

  def tags
    @object.tags.map do |tag|
      h.link_to tag.title, h.tag_path(tag.id)
    end.join(', ').html_safe
  end

  #TODO add base presenter
  private

    def h; @template end

end
