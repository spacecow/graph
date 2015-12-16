class Participation
  include ActiveModel::Model

  attr_reader :participant
  attr_writer :id, :event_id
  attr_accessor :article_id

  def event= params; @event = Event.new params end
  def event_id; @event_id || @event.id end

  def gender; participant.gender end

  def participant= params; @participant = Article.new params end

  def name; participant.name end

end
