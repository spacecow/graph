class ReferencePresenter < BasePresenter
  presents :reference

  def comment; reference.comment end

  def url
    url = reference.url
    h.link_to (url.blank? ? 'no url' : url), h.reference_path(reference.id)
  end

end
