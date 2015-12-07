class RemarkPresenter < BasePresenter

  presents :remark

  def content; remark.content end

end
