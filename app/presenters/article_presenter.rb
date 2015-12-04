class ArticlePresenter < BasePresenter
  presents :article

  def relation_groups
    article.relations.inject(Hash.new([])){|h,e| h[e.type] += [e.target]; h}.to_a
  end

  def name; h.link_to article.name, h.article_path(article.id) end

  def gender
  { 'm' => "male",
    'f' => "female",
    'n' => "neutral"}[article.gender]
  end

end
