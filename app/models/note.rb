class Note
  include ActiveModel::Model

  attr_accessor :id, :text
  attr_reader :article, :book_id
  attr_writer :article_id

  def article= params; @article = Article.new params end
  def article_id; @article_id || @article.id end

  def references; @references || [] end

  #def articles= arr
  #  @articles = arr.map do |params|
  #    Article.new(params)
  #  end
  #end

  def references= arr
    @references = arr.map do |params|
      Reference.new(params).tap do |reference|
        reference.note = self
      end
    end
  end

  def tags; @tags || [] end

  def tags= arr
    @tags = arr.map do |params|
      Tag.new(params).tap do |tag|
        tag.tagable = self
      end
    end
  end

end
