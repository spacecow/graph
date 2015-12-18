class Event
  include ActiveModel::Model

  attr_reader :children, :parents, :universe, :notes, :participations, :mentions
  attr_accessor :id, :title, :parent_tokens, :child_tokens
  attr_writer :universe_id

  def available_articles articles; articles.
    reject{|e| participant_ids.include? e.id}
  end

  def available_events events; events.
    reject{|e| e.id==id}.
    reject{|e| parent_ids.include?(e.id)}.
    reject{|e| mention_target_ids.include?(e.id)}
  end

  def children= arr
    @children = arr.map do |params|
      Event.new params
    end
  end

  def mentions= arr
    @mentions = arr.map do |params|
      Mention.new params
    end
  end
  def mention_target_ids; mentions.map(&:target_id) end

  def parents= arr
    @parents = arr.map do |params|
      Event.new params
    end
  end
  def parent_ids; parents.map(&:id) end

  def participations= arr
    @participations = arr.map do |params|
      Participation.new params
    end
  end

  def participants
    participations.map(&:participant)
  end

  def participant_ids
    participants.map(&:id)
  end

  def notes= arr
    @notes = arr.map do |params|
      Note.new params
    end
  end

  def universe_id; @universe_id || @universe.id end
  def universe_title; universe.title end
  def universe= params
    @universe = Universe.new params
  end

end
