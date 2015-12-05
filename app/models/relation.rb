class Relation
  include ActiveModel::Model

  attr_reader :target, :origin
  attr_writer :target_id, :origin_id
  attr_accessor :type, :id

  def origin= params; @origin = Article.new(params) end
  def target= params; @target = Article.new(params) end

  def origin_id; origin.try(:id) || @origin_id end
  def origin_name; origin.try(:name) end
  def origin_gender; origin.try(:gender) end

  def target_id; target.try(:id) end
  def target_name; target.name end
  def target_gender; target.gender end

  def references; @references || [] end
  def references= arr
    @references = arr.map do |params|
      Reference.new(params)
    end
  end

end
