class Tag
  include ActiveModel::Model

  attr_accessor :tagable_id, :tagable_type, :title
  attr_writer :id
end
