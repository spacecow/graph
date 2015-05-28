describe "UniversesController" do

  let(:controller){ UniversesController.new }
  let(:permitted_params){ %i(title) }

  before do
    stub_const "UniverseRunners", Module.new
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe "#universe_params" do
    let(:params){ double :params }
    let(:required_params){ double :required_params }
    before do
      def controller.params; end
      expect(controller).to receive(:params){ params }
      expect(params).to receive(:require).with(:universe){ required_params }
      expect(required_params).to receive(:permit).with(*permitted_params){ :params }
    end
    subject{ controller.send :universe_params }
    it{ is_expected.to eq :params }
  end
end
