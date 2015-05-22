describe "UniversesController#create" do

  let(:controller){ UniversesController.new }

  before do
    stub_const "UniverseRunners::Create", Class.new
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe "#create" do
    before do
      on = double :on
      expect(controller).to receive(:run).with(UniverseRunners::Create, :universe){ :universe }
      controller.class.send(:define_method, :params) do
      end && @params_defined = true unless controller.class.instance_methods(false).include?(:params)
      expect(controller).to receive(:params){ {universe: :universe} }
      controller.create
    end

    it{ subject }
  end

  after do
    controller.class.send(:remove_method, :params) if @params_defined
  end

end
