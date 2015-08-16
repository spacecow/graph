class Note
  include ActiveModel::Model

  attr_accessor :id, :article_id, :text
  attr_reader :article

  def article= params
    @article = params
  end

end
