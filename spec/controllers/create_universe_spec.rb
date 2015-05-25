describe "UniversesController#create" do

  let(:controller){ UniversesController.new }

  before do
    stub_const "UniverseRunners::Create", Class.new
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe "#create" do
    before do
      expect(controller).to receive(:run).with(UniverseRunners::Create, :universe)
      def controller.params; end
      expect(controller).to receive(:params){ {universe: :universe} }
      controller.create
    end

    it{ subject }
  end

end
