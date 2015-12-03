class Relation
  include ActiveModel::Model

  attr_reader :target
  attr_accessor :origin_id, :target_id, :type, :id

  def target= params
    @target = Article.new(params)
  end

  def references; @references || [] end
  def references= arr
    @references = arr.map do |params|
      Reference.new(params)
    end
  end

end
