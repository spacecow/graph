class Mention
  include ActiveModel::Model

  attr_reader :target
  attr_writer :origin_id
  attr_accessor :id

  def origin= params; @origin = Event.new params end
  def origin_id; @origin_id || @origin.try(:id) end

  def target= params; @target = Event.new params end
  def target_id; @target_id || @target.try(:id) end

  def target_title; target.title end
end
