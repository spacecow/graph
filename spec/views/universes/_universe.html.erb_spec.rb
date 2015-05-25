require 'view_helper'
require 'capybara'

describe 'universes/_universe.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new(file) }
  let(:file){ File.read(filepath).sub(/<%= content_tag/,'<% content_tag') }
  let(:local_bindings){ erb_bindings.instance_eval{binding} }
  let(:erb_bindings){ ErbBinding.new locals }

  let(:filepath){ './app/views/universes/_universe.html.erb' }
  let(:locals){{ universe:universe, selected:selected }}

  let(:universe){ double :universe, title:'The Malazan Empire', id:666 }
  let(:selected){ true }
  let(:presenter){ double :presenter }

  before do
    def erb_bindings.universe_path a; end
    def erb_bindings.present a; end
    def erb_bindings.content_tag a,b; end
    expect(erb_bindings).to receive(:universe_path).with(666){ "path" }
    expect(erb_bindings).to receive(:present).with(universe).and_yield presenter
    expect(erb_bindings).to receive(:content_tag).
      with(:li,class:"clazzes").and_yield
    expect(presenter).to receive(:clazz).with(selected){ "clazzes" }
  end

  subject(:li){ Capybara.string(rendering) }

  describe "rendered universe" do
    describe "title" do
      subject(:span){ li.find 'span.title' }

      its(:text){ is_expected.to include 'The Malazan Empire' }

      describe "link" do
        subject(:a){ span.find 'a' }
        its(:text){ is_expected.to eq 'The Malazan Empire' }
        its([:href]){ is_expected.to eq "path" }
      end
    end
  end

end
