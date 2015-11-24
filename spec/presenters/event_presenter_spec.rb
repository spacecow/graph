require 'active_support/core_ext/object/try'
require './app/presenters/base_presenter'
require './app/presenters/event_presenter'

describe EventPresenter do

  let(:presenter){ EventPresenter.new event, view }
  let(:event){ double :event }
  let(:view){ :view }

  subject{ presenter.send function }

  describe "#parent" do
    let(:function){ :parent }
    before{ expect(event).to receive(:parent).with(no_args){ parent }}

    context "parent exists" do
      let(:parent){ double :parent }
      before{ expect(parent).to receive(:title).with(no_args){ :title }}
      it{ should be :title }
    end

    context "parent does not exist" do
      let(:parent){ nil }
      it{ should be nil }
    end
  end

end
