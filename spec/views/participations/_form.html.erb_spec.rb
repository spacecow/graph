require 'capybara'
require 'rspec/its'

describe "participations/_form.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file.sub(/<%= form/,"<% form") }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ "./app/views/participations/_form.html.erb" }
  let(:locals){{ participation:participation, articles: :articles }}
  let(:builder){ double :builder }
  let(:participation){ double :participation }

  before do
    class ErbBinding
      def initialize(hash)
        hash.each do |key, value|
          singleton_class.send(:define_method,key){ value }
        end
        def form_for obj, *opts; raise NotImplementedError end
      end
    end
    def bind.participation_path id; raise NotImplementedError end
    expect(participation).to receive(:id).with(no_args).at_least(1){ :id }
    expect(bind).to receive(:form_for).
      with(participation, url: :path, method: :put).and_yield(builder)
    expect(bind).to receive(:participation_path).with(:id){ :path }
    expect(builder).to receive(:hidden_field).with(:event_id){ "hidden_event_id" }
    expect(builder).to receive(:label).with(:content,"Comment"){ "label_content" }
    expect(builder).to receive(:text_field).with(:content){ "text_content" }
    expect(builder).to receive(:label).
      with(:participant_id, "Participant"){ "label_article_id" }
    expect(builder).to receive(:collection_select).
      with(:participant_id, :articles, :id, :name, include_blank:true).
      and_return("select_article_id")
    expect(builder).to receive(:submit).with("Update"){ "submit_update" }
  end

  subject(:page){ Capybara.string rendering }

  describe "Form event_id" do
    its(:text){ should include "hidden_event_id" }
  end

  describe "Form content" do
    subject{ page.find 'div.content' }
    its(:text){ should match /label_content\s*text_content/m }
  end

  describe "Form participant" do
    subject{ page.find 'div.participant' }
    its(:text){ should match /label_article_id\s*select_article_id/m }
  end

  describe "Form submit" do
    its(:text){ should include "submit_update" }
  end

end
