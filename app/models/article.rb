class Article
  include ActiveModel::Model

  attr_accessor :id, :name, :type, :universe_id
  attr_reader :universe

  def notes; @notes || [] end

  def notes= arr
    @notes = arr.map do |params|
      Note.new(params).tap do |note|
        note.article = self
      end
    end
  end
  
  def target_ids; targets.map(&:id) end

  def relations; @relations || [] end

  def relatives= arr
    @relations = arr.map do |params|
      Relation.new params
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
