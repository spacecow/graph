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
  end

  it("renders the form"){ rendering }

end
