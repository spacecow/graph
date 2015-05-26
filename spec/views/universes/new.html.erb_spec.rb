require 'view_helper'

describe 'universe/new.html.erb' do

  let(:file){ 'universes/new.html.erb' }
  let(:locals){ {} }
  let(:rendering){ @erb.result @local_bindings }
  before do
    filepath = "./app/views/#{file}"
    @erb = ERB.new File.read(filepath)
    erb_bindings = ErbBinding.new(locals)
    erb_bindings.instance_variable_set "@universe", :universe
    def erb_bindings.render template, locals
      Assert.equal template, 'form' 
      Assert.equal locals, {universe: :universe} 
      "<form>New Universe</form>"
    end
    @local_bindings = erb_bindings.instance_eval{binding}
  end

  subject(:div){ Capybara.string(rendering).find '.universe.new.form' }

  describe "header" do
    subject{ div.find 'h2' }
    its(:text){ is_expected.to eq "New Universe" }
  end

  describe "form" do
    subject{ div.find 'form' }
    its(:text){ is_expected.to eq "New Universe" }
  end

end
