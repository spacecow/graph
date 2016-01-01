class Participation
  include ActiveModel::Model

  attr_reader :participant
  attr_writer :event_id, :participant_id
  attr_accessor :id, :content

  def event= params; @event = Event.new params end
  def event_id; @event_id || @event.id end

  def gender; participant.gender end

  def participant= params; @participant = Article.new params end
  def participant_id; @participant_id || @participant.try(:id) end

  def name; participant.name end

end
