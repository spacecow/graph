class ArticlePresenter < BasePresenter
  presents :article

  def relation_groups
    article.relations.inject(Hash.new([])){|h,e| h[e.type] += [e.target]; h}.to_a
  end

end
