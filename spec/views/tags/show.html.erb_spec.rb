require 'capybara'
require 'rspec/its'

describe "tags/show.html.erb" do

class ErbBinding2
  def initialize hash
    hash.each_pair do |key, value|
      instance_variable_set '@' + key.to_s, value
    end 
  end
end

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/tags/show.html.erb" }
  let(:locals){{ tag:tag }}

  let(:tag){ double :tag }

  subject(:page){ Capybara.string(rendering).find '.tag' }

  before do
    expect(tag).to receive(:title).with(no_args){ "TDP" }
  end

  describe "Tag header" do
    subject{ page.find 'h1' }
    its(:text){ should eq "TDP" }
  end

end
