class Tag
  include ActiveModel::Model

  attr_writer :tagable_id, :tagable_type
  attr_accessor :title, :id, :article_id
  
  def tagable= tagable; @tagable = tagable end

  def tagable_id; @tagable_id || @tagable.try(:id) end
  def tagable_type; @tagable_type || @tagable.class.to_s end

  def notes; @notes || [] end

  def notes= arr
    @notes = arr.map do |params|
      Note.new params
    end
  end

end
