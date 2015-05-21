describe "UniversesController#index" do

  let(:controller){ UniversesController.new }

  before do
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe "#index" do
    before do
      module UniverseRunners
        class Index; end
      end unless defined?(UniverseRunners::Index)
      expect(controller).to receive(:run).with(UniverseRunners::Index){ :universes }
      controller.class.send(:define_method, :params) do
      end && @params_defined = true unless controller.class.instance_methods(false).include?(:params)
      expect(controller).to receive(:params).at_least(1){ {id: :id} }
      controller.index   
    end

    describe '@universes' do 
      subject{ controller.instance_variable_get(:@universes) }
      it{ is_expected.to be :universes }
    end

    describe "@current_universe" do 
      subject{ controller.instance_variable_get(:@current_universe) }
      it{ is_expected.to be :id }
    end
  end

  after do
    controller.class.send(:remove_method, :params) if @params_defined
  end
end
