require 'view_helper'
require 'capybara'

describe 'universes/_universe.html.erb' do

  let(:file){ 'universes/_universe.html.erb' }
  let(:universe){ double :universe, id:1 }
  let(:locals){{ universe:universe, selected:true }}
  
  let(:universe_id){ 666 }

  before do
    filepath = "./app/views/#{file}"
    @erb = ERB.new File.read(filepath)
    erb_bindings = ErbBinding.new(locals)
    @local_bindings = erb_bindings.instance_eval{binding}
    expect(universe).to receive(:title){ "The Malazan Empire" }
    expect(universe).to receive(:id){ universe_id }
    def erb_bindings.universes_path opt; end
    expect(erb_bindings).to receive(:universes_path).with(id:universe_id){ "path" }
  end
  let(:rendering){ @erb.result @local_bindings }

  subject(:div){ Capybara.string(rendering).find('.universe') }

  describe "rendered universe" do
    describe "title" do
      subject(:span){ div.find '.title' }
      its(:text){ is_expected.to include 'The Malazan Empire' }

      describe "link" do
        subject(:a){ span.find 'a' }
        its(:text){ is_expected.to eq 'The Malazan Empire' }
        its([:href]){ is_expected.to eq "path" }
      end
    end
  end

end
