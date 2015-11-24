class Participation
  include ActiveModel::Model

  attr_accessor :event_id, :article_id
  attr_writer :id
end
