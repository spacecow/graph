require 'rspec/its'
require 'capybara'

describe 'notes/edit.html.erb' do

  let(:rendering){ erb.result local_bindings }
  let(:erb){ ERB.new file }
  let(:file){ File.read filepath }
  let(:local_bindings){ bind.instance_eval{binding} }
  let(:bind){ ErbBinding2.new locals }

  let(:filepath){ './app/views/remarks/edit.html.erb' }
  let(:locals){{ remark: :remark }}

  before do
    class ErbBinding2
      def initialize hash
        hash.each_pair do |key, value|
          instance_variable_set '@' + key.to_s, value
        end 
      end
    end
  end

  subject(:page){ Capybara.string rendering }

  #describe "Form text" do
  #  subject{ page.find 'div.text' }
    its(:text){ should include "remark" }
  #end
end
