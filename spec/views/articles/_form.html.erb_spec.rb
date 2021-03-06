require 'view_helper'

describe 'articles/_form.htm.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:file){ File.read filepath }
  let(:filepath){ './app/views/articles/_form.html.erb' }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:locals){ {article:article, article_types:%w(Character)} }
  let(:article){ double :article, id: :id, errors:errors, gender: :gender }
  let(:errors){ double :errors }

  before do
    def erb_bindings.form_for mdl, *opts; yield mdl end
    def erb_bindings.options_for_select a, b; end
    def erb_bindings.article_path id; end
    expect(article).to receive(:label).with(:name)
    expect(article).to receive(:label).with(:type)
    expect(article).to receive(:label).with(:gender)
    expect(article).to receive(:text_field).with(:name)
    expect(article).to receive(:select).with(:type, :selection, include_blank:true)
    expect(article).to receive(:select).with(:gender, :selection)
    expect(article).to receive(:submit).with("Update")
    expect(article).to receive(:type){ :type }
    expect(erb_bindings).to receive(:options_for_select).
      with(['Character'], :type){ :selection }
    expect(erb_bindings).to receive(:options_for_select).
      with([["Neutral", "n"], ["Male", "m"], ["Female", "f"]], :gender){ :selection }
  end

  context "no errors" do
    before{ expect(errors).to receive(:get).twice{ [] } }
    it("renders the form"){ rendering }
  end

  context "errors" do
    before do
      expect(errors).to receive(:get).with(:name).twice{ ["name error"] }
      expect(errors).to receive(:get).with(:type).twice{ ["type error"] }
    end
    it "renders the form with name errors" do
      expect(Capybara.string(rendering).find('.name .errors').text).
        to eq 'name error'
    end
    it "renders the form with type errors" do
      expect(Capybara.string(rendering).find('.type .errors').text).
        to eq 'type error'
    end
  end

end
