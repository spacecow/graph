class Event
  include ActiveModel::Model

  attr_accessor :id, :title, :universe_id
  attr_writer :parent_id

end
