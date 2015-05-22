require 'view_helper'
require 'capybara'

describe 'universes/index.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/universes/index.html.erb' }
  let(:locals){ {current_universe_id:1} }
  let(:universe){ double :universe, id:1 } 
  let(:universe2){ double :universe, id:2 } 
  let(:universes){ [] }

  before do
    erb_bindings.instance_variable_set "@universes", universes
    def erb_bindings.render a, b; end
    def erb_bindings.new_universe_path; "/universes/new" end
  end

  describe 'actions section' do
    subject(:ul){ Capybara.string(rendering).find('ul.actions') }
    describe 'new action' do
      subject{ ul.find('li.action.new a') }
      its(:text){ is_expected.to eq 'New Universe' }
      its([:href]){ should eq '/universes/new' }
    end
  end

  describe 'universes section' do
    subject(:div){ Capybara.string(rendering).find('.universes') }

    context 'no universe' do
      describe 'rendered universes' do
        before{ expect(erb_bindings).not_to receive(:render) }
        it("no universe is being rendered"){ subject }
      end
    end

    context "one universe" do
      let(:universes){ [universe] }
      describe "rendered universes" do
        before{ expect(erb_bindings).to receive(:render).with(universe, selected:true).once }
        it("one universe is being rendered"){ subject }
      end
    end

    context "two universes" do
      let(:universes){ [universe, universe2] }
      describe "rendered universes" do
        before do
          expect(erb_bindings).to receive(:render).with(universe,selected:true).once
          expect(erb_bindings).to receive(:render).with(universe2,selected:false).once
        end
        it("two universes is being rendered"){ subject }
      end
    end

  end
end
