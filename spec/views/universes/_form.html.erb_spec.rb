require 'view_helper'

describe 'universes/_form.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file.sub(/<%= form_for/,'<% form_for') }
  let(:file){ File.read filepath }
  let(:filepath){ './app/views/universes/_form.html.erb' }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:locals){ {universe:universe} }
  let(:universe){ double :universe, errors:errors }

  before do
    def erb_bindings.form_for mdl; yield mdl end
    expect(universe).to receive(:label).with(:title)
    expect(universe).to receive(:text_field).with(:title)
    expect(universe).to receive(:submit).with("Create")
  end

  context "no errors" do
    let(:errors){ [] }
    it("renders the form"){ rendering }
  end

  context "duplication error" do
    let(:errors){ double :errors, empty?:false }
    before do
      expect(errors).to receive(:get).
        with(:title){ ["error"] }
    end
    it "renders the form with errors" do
      expect(Capybara.string(rendering).find('.title .errors').text).
        to eq 'error'
    end
  end

end
