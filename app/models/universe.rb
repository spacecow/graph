class Universe
  include ActiveModel::Model

  attr_accessor :id, :title

  def articles; @articles || [] end

  def articles= arr
    @articles = arr.map do |params|
      case params
      when Hash
        Article.new(params).tap do |article|
          article.universe = self
        end
      when Article
        params
      end
    end
  end

end
