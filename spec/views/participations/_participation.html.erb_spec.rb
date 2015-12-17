require 'rspec/its'
require 'capybara'

describe "participations/_participation.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file.sub(/<%= content/,'<% content') }
  let(:file){ File.read filepath }

  let(:filepath){ './app/views/participations/_participation.html.erb' }
  let(:locals){{ participation: :participation }}
  let(:presenter){ double :presenter }

  before do
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
      end
    end
    def bind.present obj; raise NotImplementedError end
    def bind.content_tag tag, *opts; raise NotImplementedError end
    expect(bind).to receive(:present).with(:participation).and_yield(presenter)
    expect(bind).to receive(:content_tag).
      with(:span,class:%w(name male).join(' ')).and_yield
    expect(presenter).to receive(:name).with(no_args){ "name" }
    expect(presenter).to receive(:gender).with(no_args){ "male" }
    expect(presenter).to receive(:delete_link).with(no_args){ "delete_link" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.participation' }

  describe "Name" do
    its(:text){ is_expected.to include "name" } 
  end

  describe "Delete link" do
    subject{ page.find '.actions .delete' }
    its(:text){ is_expected.to eq "delete_link" } 
  end

end
