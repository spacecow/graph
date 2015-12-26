class Citation

  include ActiveModel::Model

  attr_writer :id
  attr_accessor :content, :origin_id

end
