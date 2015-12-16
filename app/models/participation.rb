class Participation
  include ActiveModel::Model

  attr_reader :participant
  attr_writer :id
  attr_accessor :article_id, :event_id

  def gender; participant.gender end

  def participant= params; @participant = Article.new params end

  def name; participant.name end

end
