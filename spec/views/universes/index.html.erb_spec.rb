require 'view_helper'
require 'capybara'

describe 'universes/index.html.erb' do

  let(:file){ 'universes/index.html.erb' }
  let(:locals){ {} }
  let(:rendering){ @erb.result @local_bindings }
  before do
    filepath = "./app/views/#{file}"
    @erb = ERB.new File.read(filepath)
    erb_bindings = ErbBinding.new(locals)
    erb_bindings.instance_variable_set "@universes", universes
    def erb_bindings.render mdl; mdl end
    def erb_bindings.new_universe_path; "/universes/new" end
    @local_bindings = erb_bindings.instance_eval{binding}
  end

  let(:universe){ "<div>The Malazan Empire</div>" }
  let(:universe2){ "<div>The Wheel of Time</div>" }
  let(:universes){ [] }

  describe "actions section" do
    subject(:ul){ Capybara.string(rendering).find('ul.actions') }
    describe "new action" do
      subject{ ul.find('li.action.new a') }
      its(:text){ is_expected.to eq "New Universe" }
      its([:href]){ should eq "/universes/new" }
    end
  end

  describe "universes section" do
    subject(:div){ Capybara.string(rendering).find('.universes') }

    context "no universe" do
      describe "rendered universes" do
        subject{ div.all 'div' } 
        its(:count){ is_expected.to be 0 }
      end
    end

    context "one universe" do
      let(:universes){ [universe] }
      describe "rendered universes" do
        subject{ div.all 'div' } 
        its(:count){ is_expected.to be 1 }
      end
      describe "rendered universe" do
        subject{ div.find 'div' } 
        its(:text){ is_expected.to include "The Malazan Empire" }
      end
    end

    context "two universes" do
      let(:universes){ [universe, universe2] }
      describe "rendered universes" do
        subject{ div.all 'div' } 
        its(:count){ is_expected.to be 2 }
      end
      describe "first rendered universe" do
        subject{ div.all('div').first } 
        its(:text){ is_expected.to include "The Malazan Empire" }
      end
      describe "second rendered universe" do
        subject{ div.all('div').last } 
        its(:text){ is_expected.to include "The Wheel of Time" }
      end
    end

  end
end
