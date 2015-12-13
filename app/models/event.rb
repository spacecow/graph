class Event
  include ActiveModel::Model

  attr_reader :participants, :children, :parents, :remarks, :universe, :notes
  attr_writer :remarkable_id
  attr_accessor :id, :title, :universe_id, :parent_tokens, :child_tokens

  def children= arr
    @children = arr.map do |params|
      Event.new params
    end
  end

  def parents= arr
    @parents = arr.map do |params|
      Event.new params
    end
  end
  def parent_ids; parents.map(&:id) end

  def participants= arr
    @participants = arr.map do |params|
      Article.new params
    end
  end
  def participant_ids; participants.map(&:id) end

  def notes= arr
    @notes = arr.map do |params|
      Note.new params
    end
  end

  #TODO remove
  def remarks= arr
    @remarks = arr.map do |params|
      Remark.new params
    end
  end

  def universe_title; universe.title end
  def universe= params
    @universe = Universe.new params
  end

end
