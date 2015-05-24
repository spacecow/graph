describe 'UniversesController#show' do
  
  let(:controller){ UniversesController.new }
  let(:params){ {id: :id} }

  before do
    stub_const 'UniverseRunners::Show', Class.new
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe '#show' do

    before do
      def controller.params; end
      expect(controller).to receive(:run).with(UniverseRunners::Show, :id){ :universe }
      expect(controller).to receive(:params).at_least(1){ params }
      expect(controller).to receive(:current_universe_id).
        with(:id)
      controller.show
    end


    describe '@universe' do
      subject{ controller.instance_variable_get(:@universe) }
      it{ is_expected.to be :universe }
    end

  end
end
