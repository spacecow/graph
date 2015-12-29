require 'capybara'
require 'rspec/its'

class ErbBinding2
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set '@' + key.to_s, value
    end 
  end
end

describe "tags/show.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/tags/show.html.erb" }
  let(:locals){{ tag:tag, notes: :notes }}
  let(:tag){ double :tag }
  let(:presenter){ double :presenter } 

  subject(:page){ Capybara.string(rendering).find '.tag' }

  before do
    def bind.render obj, *opts; raise NotImplementedError end
    def bind.present obj; raise NotImplementedError end
    expect(bind).to receive(:render).
      with(:notes, article_id:nil, tag_id: :tag_id){ "list" }
    expect(bind).to receive(:present).with(tag).and_yield(presenter)
    expect(presenter).to receive(:title).with(no_args){ "header" }
    expect(tag).to receive(:id).with(no_args){ :tag_id }
  end

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "header" }
  end

  describe "Listed notes" do
    subject{ page.find 'ul' }
    its(:text){ should include "list" }
  end

end
