class Mention
  include ActiveModel::Model

  attr_reader :target
  attr_writer :id

  def origin= params; @origin = Event.new params end
  def target= params; @target = Event.new params end

  def target_title; target.title end
end
