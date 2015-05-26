require 'view_helper'

describe 'universes/_form.html.erb' do

  let(:file){ 'universes/_form.html.erb' }
  let(:universe){ double :universe, label:'kuk', text_field:'fitta', submit:'balle' }
  let(:locals){ {universe:universe} }
  let(:rendering){ @erb.result @local_bindings }
  before do
    filepath = "./app/views/#{file}"
    @erb = ERB.new File.read(filepath).sub(/<%= form_for/,'<% form_for')
    erb_bindings = ErbBinding.new(locals)
    def erb_bindings.form_for(mdl)
      "<form>#{yield mdl}</form>"
    end
    @local_bindings = erb_bindings.instance_eval{binding}
  end

  it("renders the form"){ rendering }

end
