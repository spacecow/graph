class Event
  include ActiveModel::Model

  attr_reader :participants, :children, :parents, :remarks
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

  def remarks= arr
    @remarks = arr.map do |params|
      Remark.new params
    end
  end

end
