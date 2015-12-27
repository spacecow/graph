class Citation

  include ActiveModel::Model

  attr_writer :id, :origin_id
  attr_reader :target, :origin
  attr_accessor :content

  def origin= params; @origin = Article.new params end
  def origin_gender; origin.try(:gender) end
  def origin_id; @origin_id || origin.try(:id) end
  def origin_name; origin.try(:name) end

  def target= params; @target = Article.new params end
  def target_gender; target.try(:gender) end
  def target_id; target.try(:id) end
  def target_name; target.try(:name) end
end
