class Reference
  include ActiveModel::Model
  extend CarrierWave::Mount

  mount_uploader :image, ReferenceUploader

  attr_accessor :id, :url, :note_id
  attr_writer :image_data

  def image_data
    Base64.encode64 image.read
  end
end
