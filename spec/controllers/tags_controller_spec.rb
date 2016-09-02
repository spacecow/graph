require 'action_controller'

describe "TagsController" do

  let(:controller){ TagsController.new }

  before do
    stub_const "ApplicationController", Class.new unless defined?(Rails)
    require './app/controllers/tags_controller'
    def controller.params; raise NotImplementedError end
    expect(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "REST" do

    let(:tag){ double :tag }

    before{ def controller.run runner, *opts; raise NotImplementedError end }

    describe "#show" do
      let(:function){ :show }
      let(:params){{ id: :id }}
      before do
        stub_const "TagRunners::Show", Class.new
        expect(controller).to receive(:run).with(TagRunners::Show, :id){ tag }
        expect(tag).to receive(:notes).with(no_args)
      end
      it{ subject }
    end

    describe "#destroy" do
      let(:function){ :destroy }
      let(:request){ double :request }
      let(:session){ {} }
      let(:params){{ id: :id }}
      before do
        stub_const "TagRunners::Destroy", Class.new
        def controller.session; raise NotImplementedError end
        def controller.request; raise NotImplementedError end
        def controller.redirect_to path; raise NotImplementedError end
        expect(controller).to receive(:request).with(no_args){ request }
        expect(controller).to receive(:session).with(no_args).at_least(1){ session }
        expect(controller).to receive(:delete_tag_params).with(no_args){ :params }
        expect(request).to receive(:referer).with(no_args){ :path }
        expect(controller).to receive(:run).with(TagRunners::Destroy,:id,:params)
        expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      end
      it{ should eq :redirect }
      it{ subject; expect(session).to eq({}) }
    end
  end

  describe "Private" do
    describe "#tag_params" do
      let(:function){ :tag_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      before{ expect(controller).to receive(:current_universe_id).with(no_args){ :universe_id }}
      context "with params" do
        let(:params_hash){{ tag:{ tagable_id: :tagable_id,
          tagable_type: :tagable_type, title: :title, xxx: :xxx }}} 
        it{ should eq({ "tagable_id" => :tagable_id, "tagable_type" => :tagable_type,
                        "title" => :title, "universe_id" => :universe_id }) }
      end
    end
    describe "#delete_tag_params" do
      let(:function){ :delete_tag_params }
      let(:params){ ActionController::Parameters.new(params_hash) }
      context "with params" do
        let(:params_hash){{ tag:{ tagable_id: :tagable_id,
          tagable_type: :tagable_type, title: :title, xxx: :xxx }}} 
        it{ should eq({ "tagable_id" => :tagable_id,
          "tagable_type" => :tagable_type }) }
      end
    end
  end

end
