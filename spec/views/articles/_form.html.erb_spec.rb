require 'view_helper'

describe 'articles/_form.htm.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file.gsub(/<%= form/,"<% form") }
  let(:file){ File.read filepath }
  let(:filepath){ './app/views/articles/_form.html.erb' }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }
  let(:locals){ {article:article} }
  let(:article){ double :article }

  before do
    def erb_bindings.form_for mdl; yield mdl end
    def erb_bindings.options_for_select a; end
    expect(article).to receive(:label).with(:name)
    expect(article).to receive(:label).with(:type)
    expect(article).to receive(:text_field).with(:name)
    expect(article).to receive(:select).with(:type, :selection, include_blank:true)
    expect(article).to receive(:submit).with("Create")
    expect(erb_bindings).to receive(:options_for_select).
      with(['Character']){ :selection }
    allow(article).to receive(:errors){ errors }
  end

  context "no errors" do
    let(:errors){ [] }
    it("renders the form"){ rendering }
  end

  context "name error" do
    let(:errors){ double :errors, empty?:false }
    before do
      expect(errors).to receive(:get).
        with(:name){ ["error"] }
    end
    it "renders the form with errors" do
      expect(Capybara.string(rendering).find('.name .errors').text).
        to eq 'error'
    end
  end

end
