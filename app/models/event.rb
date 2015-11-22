class Event
  include ActiveModel::Model

  attr_accessor :id, :title
  attr_writer :universe_id, :parent_id

end
