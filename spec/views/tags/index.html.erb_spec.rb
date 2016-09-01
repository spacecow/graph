require 'capybara'
require 'rspec/its'

describe "tags/index.html.erb" do

  let(:bind){ ErbBinding2.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/tags/index.html.erb" }
  let(:locals){{ tags: :tags }} 

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
      def link_to link, path; "<a href='#{path}'>#{link}</a>" end
    end
    def bind.new_tag_path; raise NotImplementedError end 
    def bind.render template; raise NotImplementedError end
    expect(bind).to receive(:new_tag_path).with(no_args){ "new_tag_path" }
    expect(bind).to receive(:render).with(:tags){ "render_tags" }
  end

  subject(:div){ Capybara.string(rendering).find 'div.tags.list' }

  describe "List tags" do
    subject{ div.find 'ul.tags' }
    its(:text){ should eq "render_tags" }
  end

  describe "Actions" do
    subject(:ul){ div.find('ul.actions') }
    describe "New Tag" do
      subject{ ul.find('a') }
      its(:text){ is_expected.to eq "New Tag" }
      its([:href]){ is_expected.to eq "new_tag_path" }
    end
  end

end
