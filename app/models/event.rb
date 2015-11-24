class Event
  include ActiveModel::Model

  attr_reader :parent, :participants
  attr_accessor :id, :title, :universe_id, :parent_id

  def parent= params
    @parent = Event.new params
  end

  def participants= arr
    @participants = arr.map do |params|
      Article.new(params)
    end
  end

  def participant_ids; participants.map(&:id) end

end
