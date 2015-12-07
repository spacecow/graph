class Remark
  include ActiveModel::Model

  attr_writer :id, :remarkable_id
  attr_accessor :content
end
