require 'capybara'
require 'rspec/its'

describe 'layouts/_layouts.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:bind){ ErbBinding2.new locals }

  let(:filepath){ './app/views/layouts/_header.html.erb' }
  let(:locals){{ note:note, reference:reference }}
  let(:note){ nil }
  let(:reference){ nil }

  subject(:div){ Capybara.string(rendering).find 'div#header' }

  before do
    class ErbBinding2
      def initialize(hash)
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
      def universes_path; raise NotImplementedError end
      def universe_path id; raise NotImplementedError end
      def events_path; raise NotImplementedError end
      def article_path id; raise NotImplementedError end
      def note_path id; raise NotImplementedError end
      def link_to link, path; "<a href='#{path}'>#{link}</a>" end
    end
    def bind.current_universe_id; end
    expect(bind).to receive(:universes_path).with(no_args){ "universe_path" }
    expect(bind).to receive(:universe_path).with(:universe_id){ "articles_path" }
    expect(bind).to receive(:events_path).with(no_args){ "events_path" }
    expect(bind).to receive(:current_universe_id).
      with(no_args).at_least(1){ :universe_id }
  end

  describe "Universes link" do
    subject{ div.all('a').first }
    its(:text){ is_expected.to eq "Universes" }
    its([:href]){ is_expected.to eq "universe_path" }
  end

  describe "Articles link" do
    subject{ div.all('a')[1] }
    its(:text){ is_expected.to eq "Articles" }
    its([:href]){ is_expected.to eq "articles_path" }
  end

  describe "Events link" do
    subject{ div.all('a')[2] }
    its(:text){ is_expected.to eq "Events" }
    its([:href]){ is_expected.to eq "events_path" }
  end

  describe "Notes link" do
    let(:note){ double :note, article_id: :article_id }
    before do
      expect(bind).to receive(:article_path).with(:article_id){ "notes_path" }
    end
    subject{ div.all('a')[3] }
    its(:text){ is_expected.to eq "Notes" }
    its([:href]){ is_expected.to eq "notes_path" }
  end

  describe "References link" do
    let(:reference){ double :reference, note_id: :note_id }
    before do
      expect(bind).to receive(:note_path).with(:note_id){ "references_path" }
    end
    subject{ div.all('a')[3] }
    its(:text){ is_expected.to eq "References" }
    its([:href]){ is_expected.to eq "references_path" }
  end

end 
