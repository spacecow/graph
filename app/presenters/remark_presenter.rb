class RemarkPresenter < BasePresenter

  presents :remark

  def content; remark.content end

  def edit_link; h.link_to "Edit", h.edit_remark_path(remark.id) end

end
