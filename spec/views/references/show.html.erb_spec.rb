require 'view_helper'

describe "references/show.html.erb" do

  let(:bind){ ErbBinding.new locals }
  let(:local_bindings){ bind.instance_eval{ binding }}
  let(:file){ File.read filepath }
  let(:erb){ ERB.new file }
  let(:rendering){ erb.result local_bindings }

  let(:filepath){ './app/views/references/show.html.erb' }
  let(:locals){ {} }

  subject(:div){ Capybara.string(rendering).find '.reference' }

end
