require 'view_helper'
require 'capybara'

describe 'universes/_universe.html.erb' do

  let(:file){ 'universes/_universe.html.erb' }
  let(:universe){ double :universe }
  let(:locals){{ universe:universe }}

  before do
    filepath = "./app/views/#{file}"
    @erb = ERB.new File.read(filepath)
    erb_bindings = ErbBinding.new(locals)
    @local_bindings = erb_bindings.instance_eval{binding}
    expect(universe).to receive(:title){ "The Malazan Empire" }
  end
  let(:rendering){ @erb.result @local_bindings }

  subject(:div){ Capybara.string(rendering).find('.universe') }

  describe "rendered universe" do
    describe "title" do
      subject{ div.find '.title' }
      its(:text){ is_expected.to include 'The Malazan Empire' }
    end
  end

end
