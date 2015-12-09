require 'rspec/its'
require 'capybara'

describe 'notes/edit.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:bind){ ErbBinding2.new locals }

  let(:filepath){ './app/views/remarks/edit.html.erb' }
  let(:locals){{ remark:remark }}
  let(:remark){ double :remark }

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
    end
    def bind.render obj,*opts; raise NotImplementedError end
    expect(remark).to receive(:remarkable_id).with(no_args){ :remarkable_id }
    expect(bind).to receive(:render).
      with("remarks/form",remark:remark, event_id: :remarkable_id).
      and_return("remark_form")
  end

  subject(:page){ Capybara.string rendering }

  describe "Remark form" do
    subject{ page.find '.remark.edit.form' }
    its(:text){ should include "remark_form" }
  end

end
