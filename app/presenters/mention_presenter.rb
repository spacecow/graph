class MentionPresenter < BasePresenter

  presents :mention

  def target_title; h.link_to mention.target_title, h.event_path(mention.target_id) end

end
