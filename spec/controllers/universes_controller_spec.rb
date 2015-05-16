#require 'rails_helper'

describe "UniversesController" do
  let(:controller){ UniversesController.new }

  before do
    module UniverseRunners; end unless defined?(UniverseRunners)
    module ActionController
      class Base
        def self.protect_from_forgery s; end
      end
    end unless defined?(ActionController)
    require File.expand_path '../../../app/controllers/application_controller', __FILE__
    require File.expand_path '../../../app/controllers/universes_controller', __FILE__
    @params_defined = false
  end

  describe "#create" do
    before do
      module UniverseRunners
        class Create; end
      end unless defined?(UniverseRunners::Create)
      on = double :on
      expect(controller).to receive(:run).with(UniverseRunners::Create, :universe){ :universe }
      controller.class.send(:define_method, :params) do
      end && @params_defined = true unless controller.class.instance_methods(false).include?(:params)
      expect(controller).to receive(:params){ {universe: :universe} }
      controller.create
    end

    it{ subject }
  end

  describe "#new" do
    before do
      module UniverseRunners
        class New; end
      end unless defined?(UniverseRunners::New)
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
      module UniverseRunners
        class Index; end
      end unless defined?(UniverseRunners::Index)
      expect(controller).to receive(:run).with(UniverseRunners::Index){ :universes }
      controller.class.send(:define_method, :params) do
      end && @params_defined = true unless controller.class.instance_methods(false).include?(:params)
      expect(controller).to receive(:params).at_least(1){ {id: :id} }
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

  after do
    controller.class.send(:remove_method, :params) if @params_defined
  end

end
