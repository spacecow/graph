class Relation
  include ActiveModel::Model

  attr_reader :target
  attr_writer :target_id
  attr_accessor :origin_id, :type, :id

  def target= params; @target = Article.new(params) end

  def target_id; target.try(:id) end
  def target_name; target.name end

  def references; @references || [] end
  def references= arr
    @references = arr.map do |params|
      Reference.new(params)
    end
  end

end
