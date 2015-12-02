class Reference
  include ActiveModel::Model
  extend CarrierWave::Mount

  mount_uploader :image, ReferenceUploader

  attr_accessor :id, :url, :referenceable_id, :comment, :referenceable_type
  attr_writer :image_data

  #TODO replace with writer?
  def note= note 
  #  @note = note
  end

  def image_data
    @image_data || Base64.encode64(image.read || "")
  end
end
