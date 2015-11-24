class Event
  include ActiveModel::Model

  attr_reader :parent, :articles
  attr_accessor :id, :title, :universe_id, :parent_id

  def parent= params
    @parent = Event.new params
  end

  #TODO change to participants
  def articles= arr
    @articles = arr.map do |params|
      Article.new(params)
    end
  end

end
