class ReferencePresenter

  def initialize object, template
    @object = object
    @template = template
  end

  def url
    url = @object.url
    h.link_to (url.blank? ? 'no url' : url), h.reference_path(@object.id)
  end

  private

    def h; @template end

end
