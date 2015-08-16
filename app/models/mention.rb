class Mention
  include ActiveModel::Model

  def image_data= data
    @image_data = Base64.encode64 data.read
  end
end
