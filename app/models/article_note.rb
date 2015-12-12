class ArticleNote
  include ActiveModel::Model

  attr_accessor :note_id
  attr_writer :article_id, :id
end
