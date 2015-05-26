require 'view_helper'
require 'rspec/its'

describe 'layouts/_layouts.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/layouts/_header.html.erb' }
  let(:locals){ {} }

  subject(:div){ Capybara.string(rendering).find 'div#header a' }

  before do
    def erb_bindings.universes_path; end
    expect(erb_bindings).to receive(:universes_path){ "path" }
  end

  its(:text){ is_expected.to eq 'Universes' }
  its([:href]){ is_expected.to eq 'path' }

end 
