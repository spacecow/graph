class Participation
  include ActiveModel::Model

  attr_reader :participant
  attr_writer :id
  attr_accessor :article_id, :event_id

  def participant= params; @participant = Article.new params end

end
