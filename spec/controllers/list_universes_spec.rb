describe 'UniversesController#index' do

  let(:controller){ UniversesController.new }
  let(:params){ {id: :id} }

  before do
    stub_const 'UniverseRunners::Index', Class.new
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe '#index' do
    before do
      expect(controller).to receive(:run).with(UniverseRunners::Index){ :universes }
      controller.index   
    end

    describe '@universes' do 
      subject{ controller.instance_variable_get(:@universes) }
      it{ is_expected.to be :universes }
    end

  end
end
