require 'view_helper'
require 'capybara'

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
    expect(article).to receive(:label).with(:name)
    expect(article).to receive(:text_field).with(:name)
  end

  it("renders the form"){ rendering }

end
