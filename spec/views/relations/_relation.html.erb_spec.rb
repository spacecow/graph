require 'rspec/its'
require 'capybara'

describe 'relations/_relation.html.erb' do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= content/,'<% content') }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/relations/_relation.html.erb' }
  let(:locals){{ relation:mdl }}
  let(:mdl){ double :relation }
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
    expect(bind).to receive(:present).with(mdl).and_yield(presenter)
    expect(bind).to receive(:content_tag).with(:span, class:%w(target male).join(" ")).and_yield
    expect(presenter).to receive(:target_gender).with(no_args){ "male" }
    expect(presenter).to receive(:target).with(no_args){ "target" }
    expect(presenter).to receive(:type).with(no_args){ "type" }
    expect(presenter).to receive(:invert_link).with(no_args){ "invert_link" }
    expect(presenter).to receive(:references_comments).with(no_args){ "comments" }
  end

  subject(:page){ Capybara.string(rendering).find 'li.relation' }

  describe "Target name" do
    its(:text){ should include "target" }
  end

  describe "References comments" do
    subject{ page.find '.references.comments' }
    its(:text){ should eq "comments" }
  end

  describe "Relation type" do
    subject{ page.find '.type' }
    its(:text){ should eq "type" }
  end

  describe "Actions" do
    subject(:span){ page.find('span.actions') }
    describe "Invert link" do
      subject{ page.find '.actions .invert' }
      its(:text){ should eq "invert_link" }
    end
  end

end
