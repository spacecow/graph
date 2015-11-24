class NotePresenter < BasePresenter
  presents :note

  def tags
    note.tags.map do |tag|
      h.link_to tag.title, h.tag_path(tag.id)
    end.join(', ').html_safe
  end

end
