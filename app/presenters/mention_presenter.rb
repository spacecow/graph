class MentionPresenter < BasePresenter

  presents :mention

  def content
    content = mention.content
    content = "Edit" if content.blank?
    (" - " + h.link_to(content, h.edit_mention_path(mention.id))).
      html_safe
  end

  def origin_title; h.link_to mention.origin_title, h.event_path(mention.origin_id) end

  def target_title; h.link_to mention.target_title, h.event_path(mention.target_id) end

end
