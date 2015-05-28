describe "UniversesController#create" do

  let(:controller){ UniversesController.new }

  before do
    stub_const "UniverseRunners::Create", Class.new
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe "#create" do
    before do
      expect(controller).to receive(:run).with(UniverseRunners::Create, :params)
      expect(controller).to receive(:universe_params){ :params }
      controller.create
    end

    it{ subject }
  end

end
