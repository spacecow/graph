class Tagging
  include ActiveModel::Model

  attr_accessor :id, :tag_id, :tagable_type, :tagable_id
end
