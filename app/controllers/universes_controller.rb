class UniversesController < ApplicationController
  def index
    @universes = [Universe.new(title:'The Malazan Empire')]
  end
end
