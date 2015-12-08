class Remark
  include ActiveModel::Model

  attr_writer :id
  attr_accessor :content, :remarkable_id

end
