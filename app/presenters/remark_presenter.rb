class RemarkPresenter < BasePresenter

  presents :remark

  def content; remark.content end

  def edit_link event_id:
    h.link_to "Edit",
      h.edit_remark_path(remark.id,event_id:event_id)
  end

end
