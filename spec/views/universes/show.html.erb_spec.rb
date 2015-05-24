require 'view_helper'
require 'capybara'

describe 'universes/show.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/universes/show.html.erb' }
  let(:locals){ {} }
  let(:universe){ double :universe, title:'The Malazan Empire' }

  before do
    erb_bindings.instance_variable_set "@universe", universe
  end

  subject(:div){ Capybara.string(rendering).find '.universe' }

  describe "header" do
    subject{ div.find 'h2' }
    its(:text){ is_expected.to eq 'The Malazan Empire' }
  end

end
