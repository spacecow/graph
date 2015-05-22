describe "UniversesController#index" do

  let(:controller){ UniversesController.new }

  before do
    stub_const "UniverseRunners::Index", Class.new
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe "#index" do
    before do
      expect(controller).to receive(:run).with(UniverseRunners::Index){ :universes }
      controller.class.send(:define_method, :params) do
      end && @params_defined = true unless controller.class.instance_methods(false).include?(:params)
      expect(controller).to receive(:params){ {id: :id} }
      expect(controller).to receive(:current_universe_id).with(:id)
      controller.index   
    end

    describe '@universes' do 
      subject{ controller.instance_variable_get(:@universes) }
      it{ is_expected.to be :universes }
    end

  end

  after do
    controller.class.send(:remove_method, :params) if @params_defined
  end
end
