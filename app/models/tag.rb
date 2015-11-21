class Tag
  include ActiveModel::Model

  attr_accessor :tagable_id, :tagable_type, :title, :id
  
  def tagable= tagable
  end

  def notes; @notes || [] end

  def notes= arr
    @notes = arr.map do |params|
      Note.new params
    end
  end

end
