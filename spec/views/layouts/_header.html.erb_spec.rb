require 'view_helper'
require 'rspec/its'

describe 'layouts/_layouts.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:bind){ ErbBinding.new locals }

  let(:filepath){ './app/views/layouts/_header.html.erb' }
  let(:locals){ {} }

  subject(:div){ Capybara.string(rendering).find 'div#header' }

  before do
    def bind.universes_path; end
    def bind.universe_path id; end
    def bind.current_universe_id; end
    expect(bind).to receive(:universes_path){ "universe_path" }
    expect(bind).to receive(:universe_path).with(:id){ "articles_path" }
    expect(bind).to receive(:current_universe_id).at_least(1){ :id }
  end

  describe "Universes link" do
    subject{ div.all('a').first }
    its(:text){ is_expected.to eq 'Universes' }
    its([:href]){ is_expected.to eq 'universe_path' }
  end

  describe "Articles link" do
    subject{ div.all('a').last }
    its(:text){ is_expected.to eq 'Articles' }
    its([:href]){ is_expected.to eq 'articles_path' }
  end

end 
