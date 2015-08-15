class Note
  include ActiveModel::Model

  attr_accessor :id, :article_id

  def article= params
    @article = params
  end

end
