class Article
  include ActiveModel::Model

  attr_accessor :id, :name, :type, :universe_id, :gender
  attr_reader :universe

  def events; @events || [] end

  def events= arr
    @events = arr.map do |params|
      Event.new(params)
    end
  end

  def notes; @notes || [] end

  def notes= arr
    @notes = arr.map do |params|
      Note.new(params)
    end
  end
  
  def target_ids; targets.map(&:id) end
  def targets; relations.map(&:target) end

  def relations; @relations || [] end

  def relatives= arr
    @relations = arr.map do |params|
      Relation.new params
    end
  end

  def tags; @tags || [] end
  def tags= arr
    @tags = arr.map do |params|
      Tag.new params
    end
  end

  def universe= params
    @universe = case params
    when Hash
      Universe.new(params).tap do |universe|
        universe.articles = [self]
      end
    when Universe
      params
    end
  end

end
