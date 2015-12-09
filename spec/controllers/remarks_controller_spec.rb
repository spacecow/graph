describe "RemarksController" do

  let(:controller){ RemarksController.new }

  before do
    class ApplicationController; end unless defined?(Rails)
    require './app/controllers/remarks_controller'
    def controller.event_path id; raise NotImplementedError end
    def controller.redirect_to path; raise NotImplementedError end
    def controller.params; raise NotImplementedError end
    def controller.run *opts; raise NotImplementedError end
    allow(controller).to receive(:params).with(no_args){ params }
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    let(:params){{ event_id: :event_id }}
    let(:runner){ double :runner }
    before do
      stub_const "RemarkRunners::Create", Class.new
      expect(controller).to receive(:remark_params).with(no_args){ :params }
      expect(controller).to receive(:event_path).with(:event_id){ :path }
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(controller).to receive(:run).
        with(RemarkRunners::Create,:params,:event_id).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield
    end
    it{ subject }
  end

  describe "#edit" do
    let(:function){ :edit }
    let(:params){{ id: :id, event_id: :event_id }}
    let(:runner){ double :runner }
    before do
      stub_const "RemarkRunners::Edit", Class.new
      expect(controller).to receive(:run).
        with(RemarkRunners::Edit,:id,:event_id).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield(:remark)
    end
    it{ subject }
  end

  describe "#update" do
    let(:function){ :update }
    let(:params){{ id: :id, event_id: :event_id }}
    let(:runner){ double :runner }
    before do
      stub_const "RemarkRunners::Update", Class.new
      expect(controller).to receive(:redirect_to).with(:path){ :redirect }
      expect(controller).to receive(:event_path).with(:event_id){ :path }
      expect(controller).to receive(:remark_params).with(no_args){ :params }
      expect(controller).to receive(:run).
        with(RemarkRunners::Update,:id,:params).and_yield(runner)
      expect(runner).to receive(:success).with(no_args).and_yield
    end
    it{ subject }
  end

end
