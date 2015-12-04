describe 'UniversesController#show' do
  
  let(:controller){ UniversesController.new }
  let(:params){ {id: :id} }
  let(:universe){ double :universe }

  before do
    stub_const 'UniverseRunners::Show', Class.new
    require 'controller_helper'
    require './app/controllers/universes_controller'
  end

  describe '#show' do

    let(:article){ double :article, id: :id }

    before do
      def controller.params; end
      expect(controller).to receive(:run).with(UniverseRunners::Show, :id){ universe }
      expect(controller).to receive(:params).at_least(1){ params }
      expect(controller).to receive(:current_universe_id).with(:id)
      expect(universe).to receive(:articles){ [article] }
      controller.show
    end

    describe '@universe' do
      subject{ controller.instance_variable_get(:@universe) }
      it{ is_expected.to be universe }
    end

    describe '@articles' do
      subject{ controller.instance_variable_get(:@articles) }
      it{ is_expected.to eq [article] }
    end

  end
end
