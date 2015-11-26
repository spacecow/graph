class Step
  include ActiveModel::Model

  attr_accessor :parent_id, :child_id
  attr_writer :id

end
