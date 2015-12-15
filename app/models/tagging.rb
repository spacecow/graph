class Tagging
  include ActiveModel::Model

  attr_accessor :id, :tag_id, :tagable_id, :tagable_type, :note_id, :article_id
end
