describe "UniversesController#new" do
  
  let(:controller){ UniversesController.new }

  before do
    module UniverseRunners; end unless defined?(UniverseRunners)
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe "#new" do
    before do
      module UniverseRunners
        class New; end
      end unless defined?(UniverseRunners::New)
      expect(controller).to receive(:run).with(UniverseRunners::New){ :universe }
      controller.new
    end

    describe "@universe" do
      subject{ controller.instance_variable_get(:@universe) }
      it{ is_expected.to be :universe }
    end
  end

end
