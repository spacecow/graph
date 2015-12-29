class ArticleMention
  include ActiveModel::Model

  attr_reader :target
  attr_writer :id, :origin_id
  attr_accessor :content

  def origin= params; @origin = Event.new params end
  def origin_id; @origin_id || @origin.try(:id) end

  def target= params; @target = Article.new params end
  def target_name; target.try(:name) end
  def target_id; @target_id || @target.try(:id) end
end
