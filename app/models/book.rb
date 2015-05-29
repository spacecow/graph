class Book
  include ActiveModel::Model

  attr_writer :id, :title, :universe_id
end
