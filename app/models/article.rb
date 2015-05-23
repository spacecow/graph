class Article
  include ActiveModel::Model

  attr_accessor :id, :name, :universe_id
  attr_reader :universe

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
