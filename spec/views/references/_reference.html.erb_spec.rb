require 'view_helper'

describe 'references/_reference.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:reference){ double :reference }
  let(:filepath){ './app/views/references/_reference.html.erb' }
  let(:locals){{ reference:reference }}
  let(:presenter){ double :presenter }

  before do
    def bind.present mdl; end
    expect(bind).to receive(:present).with(reference).and_yield presenter
    expect(presenter).to receive(:comment){ 'smart' }
    expect(presenter).to receive(:url){ 'www.example.com' }
  end

  subject(:li){ Capybara.string(rendering).find 'li.reference' }

  describe 'comment' do
    subject{ li.find '.comment' }
    its(:text){ is_expected.to include 'smart' }
  end

  describe 'url' do
    subject{ li.find '.url' }
    its(:text){ is_expected.to include 'www.example.com' }
  end

end
