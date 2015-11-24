describe "ParticipationsController" do

  let(:controller){ ParticipationsController.new }

  before do
    class ApplicationController; end
    require './app/controllers/participations_controller'
  end

  subject{ controller.send function }

  describe "#create" do
    let(:function){ :create }
    it{ subject }
  end
end
