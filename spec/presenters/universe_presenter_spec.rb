require './app/presenters/base_presenter'
require './app/presenters/universe_presenter'

describe UniversePresenter do

  let(:presenter){ UniversePresenter.new :object, :template }

  describe "#clazz" do
    let(:selected){ true }
    subject{ presenter.clazz selected }

    context 'universe is selected' do
      it{ is_expected.to eq 'universe selected' }
    end

    context 'universe is not selected' do
      let(:selected){ false }
      it{ is_expected.to eq 'universe' }
    end
  end

end
