require 'rails_helper'

describe UniversesController do

  describe "#index" do
    let(:params){ {} }

    before do
      expect(controller).to receive(:run) 
      get :index, params 
    end

    context "without universe id" do
      subject{ assigns(:current_universe) }
      it{ is_expected.to be nil }
    end

    context "with universe id" do
      let(:params){ {id:25} }
      subject{ assigns(:current_universe) }
      it{ is_expected.to eq "25" }
    end
  end

end
