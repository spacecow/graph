class ArticleMentionPresenter < BasePresenter

  presents :mention

  def content
    content = mention.content
    return if content.nil?
    content = "Edit" if content.blank?
    (" - " + h.link_to(content, h.edit_article_mention_path(mention.id))).
      html_safe
  end

  def gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral" }[mention.gender]
  end

  def target_name; h.link_to mention.target_name, h.article_path(mention.target_id) end

end
