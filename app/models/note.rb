class Note
  include ActiveModel::Model

  attr_accessor :id, :article_id, :text
  attr_reader :article

  def article= article
    @article = article
  end

  def references; @references || [] end

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
