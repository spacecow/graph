require 'active_support/core_ext/object/blank'
require './app/presenters/base_presenter'
require './app/presenters/reference_presenter'

describe ReferencePresenter do

  let(:reference){ double :reference }
  let(:template){ double :template }
  let(:presenter){ ReferencePresenter.new reference, template }

  describe "#url" do
    
    subject{ presenter.url }

    before do
      expect(reference).to receive(:url){ url }
      expect(reference).to receive(:id){ 666 }
      expect(template).to receive(:reference_path).with(666){ :path }
    end

    context "url exists" do
      let(:url){ :url }
      before do
        expect(template).to receive(:link_to).with(:url, :path){ :link }
      end
      it{ is_expected.to eq :link }
    end

    context "url does not exist" do
      let(:url){ nil }
      before do
        expect(template).to receive(:link_to).with('no url', :path){ :link }
      end
      it{ is_expected.to eq :link }
    end

    context "url is blank" do
      let(:url){ "" }
      before do
        expect(template).to receive(:link_to).with('no url', :path){ :link }
      end
      it{ is_expected.to eq :link }
    end

  end
end
