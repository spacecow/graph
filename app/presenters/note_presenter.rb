class NotePresenter < BasePresenter
  presents :note

  def tags
    note.tags.map do |tag|
      h.link_to tag.title, h.tag_path(tag.id)
    end.join(', ').html_safe
  end

  def edit_link; h.link_to "Edit", h.edit_note_path(note.id) end

end
