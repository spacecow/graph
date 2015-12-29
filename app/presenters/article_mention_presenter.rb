class ArticleMentionPresenter < BasePresenter

  presents :mention

  def content
    return if mention.content.nil?
    " - " + mention.content
  end

  def target_name; h.link_to mention.target_name, h.article_path(mention.target_id) end

end
