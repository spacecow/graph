#require 'rails_helper'

describe "UniversesController" do
  let(:controller){ UniversesController.new }

  before do
    module UniverseRunners; end
    module ActionController
      class Base
        def self.protect_from_forgery s; end
      end
    end
    require File.expand_path '../../../app/controllers/application_controller', __FILE__
    require File.expand_path '../../../app/controllers/universes_controller', __FILE__
  end

  describe "#create" do
    before do
      module UniverseRunners; class Create; end end
      on = double :on
      expect(controller).to receive(:run).with(UniverseRunners::Create, :universe){ :universe }
      controller.class.send(:define_method, :params) do
        {universe: :universe}
      end
      controller.create
    end

    it{ subject }
  end

  describe "#new" do
    before do
      module UniverseRunners; class New; end end
      expect(controller).to receive(:run).with(UniverseRunners::New){ :universe }
      controller.new
    end

    describe "@universe" do
      subject{ controller.instance_variable_get(:@universe) }
      it{ is_expected.to be :universe }
    end
  end

  describe "#index" do
    before do
      module UniverseRunners; class Index; end end
      expect(controller).to receive(:run).with(UniverseRunners::Index){ :universes }
      controller.class.send(:define_method, :params) do
        {id: :id}
      end
      controller.index   
    end

    describe "@universe" do 
      subject{ controller.instance_variable_get(:@universes) }
      it{ is_expected.to be :universes }
    end

    describe "@current_universe" do 
      subject{ controller.instance_variable_get(:@current_universe) }
      it{ is_expected.to be :id }
    end
  end

end
