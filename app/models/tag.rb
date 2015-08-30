class Tag
  include ActiveModel::Model

  attr_accessor :tagable_id, :tagable_type, :title, :id
  
  def tagable= tagable
  end

end
