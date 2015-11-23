class Event
  include ActiveModel::Model

  attr_reader :parent
  attr_accessor :id, :title, :universe_id, :parent_id

  def parent= params
    @parent = Event.new params
  end

end
