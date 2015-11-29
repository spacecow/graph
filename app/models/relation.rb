class Relation
  include ActiveModel::Model

  attr_writer :id
  attr_reader :target
  attr_accessor :origin_id, :target_id, :type

  def target= params
    @target = Article.new(params)
  end

end
