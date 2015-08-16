require 'view_helper'

describe 'universes/_universe.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read(filepath).sub(/<%= content_tag/,'<% content_tag') }
  let(:erb){ ERB.new(file) }
  let(:rendering){ erb.result local_bindings }

  let(:universe){ double :universe, title:'The Malazan Empire', id:666 }
  let(:filepath){ './app/views/universes/_universe.html.erb' }
  let(:locals){{ universe:universe, selected:selected }}

  let(:selected){ true }
  let(:presenter){ double :presenter }

  before do
    def bind.universe_path a; end
    def bind.present a; end
    def bind.content_tag a,b; end
    expect(bind).to receive(:universe_path).with(666){ "path" }
    expect(bind).to receive(:present).with(universe).and_yield presenter
    expect(bind).to receive(:content_tag).
      with(:li,class:"clazzes").and_yield
    expect(presenter).to receive(:clazz).with(selected){ "clazzes" }
  end

  subject(:li){ Capybara.string(rendering) }

  describe "title" do
    subject(:title){ li.find '.title' }
    its(:text){ is_expected.to include 'The Malazan Empire' }

    describe "link" do
      subject{ title.find 'a' }
      its(:text){ is_expected.to eq 'The Malazan Empire' }
      its([:href]){ is_expected.to eq "path" }
    end
  end

end
