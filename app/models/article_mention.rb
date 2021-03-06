class ArticleMention
  include ActiveModel::Model

  attr_reader :target, :origin
  attr_writer :origin_id, :target_id
  attr_accessor :id, :content

  def gender; target.try(:gender) end

  def origin= params; @origin = Event.new params end
  def origin_title; origin.try(:title) end
  def origin_id; @origin_id || @origin.try(:id) end

  def target= params; @target = Article.new params end
  def target_name; target.try(:name) end
  def target_id; @target_id || @target.try(:id) end

end
