class Event
  include ActiveModel::Model

  attr_reader :participants, :children, :parents
  attr_accessor :id, :title, :universe_id, :parent_tokens, :child_tokens

  def parents= arr
    @parents = arr.map do |params|
      Event.new(params)
    end
  end

  def parent_ids; parents.map(&:id) end

  def children= arr
    @children = arr.map do |params|
      Event.new(params)
    end
  end

  def participants= arr
    @participants = arr.map do |params|
      Article.new(params)
    end
  end

  def participant_ids; participants.map(&:id) end

end
