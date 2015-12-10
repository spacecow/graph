class NotePresenter < BasePresenter
  presents :note

  def tags
    note.tags.map do |tag|
      h.link_to tag.title, h.tag_path(tag.id)
    end.join(', ').html_safe
  end

  def edit_link; h.link_to "Edit", h.edit_note_path(note.id) end

  def delete_link article_id:, tag_id:
    h.link_to "Delete", h.note_path(note.id, article_id:article_id, tag_id:tag_id),
      method: :delete, data:{confirm:"Are you sure?"}
  end
end
