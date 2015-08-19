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

  before do
    def bind.reference_path id; end
    expect(reference).to receive(:id){ 666 }
    expect(reference).to receive(:url){ 'www.example.com' }
    expect(bind).to receive(:reference_path).with(666){ "path" }
  end

  subject(:li){ Capybara.string(rendering).find 'li.reference' }

  describe 'url' do
    subject(:url){ li.find '.url' }
    its(:text){ is_expected.to include 'www.example.com' }

    describe "link" do
      subject{ url.find 'a' }
      its(:text){ is_expected.to eq 'www.example.com' }
      its([:href]){ is_expected.to eq "path" }
    end
  end

end
