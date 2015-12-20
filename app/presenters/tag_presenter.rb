class TagPresenter < BasePresenter

  presents :tag

  def delete_link
    params = {tag:{tagable_type:tag.tagable_type, tagable_id:tag.tagable_id}}
    h.link_to "Delete", h.tag_path(tag.id, params), method: :delete, data:{confirm:"Are you sure?"}
  end

  def title; tag.title end

end
