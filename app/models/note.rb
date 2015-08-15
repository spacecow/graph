class Note
  include ActiveModel::Model

  attr_accessor :id, :article_id, :text

  def article= params
    @article = params
  end

end
