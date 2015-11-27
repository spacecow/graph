class Relation
  include ActiveModel::Model

  attr_writer :id
  attr_accessor :origin_id, :target_id, :type
end
