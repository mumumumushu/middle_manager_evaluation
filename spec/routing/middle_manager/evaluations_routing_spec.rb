require "rails_helper"

RSpec.describe MiddleManager::EvaluationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/middle_manager/evaluations").to route_to("middle_manager/evaluations#index")
    end

    it "routes to #new" do
      expect(:get => "/middle_manager/evaluations/new").to route_to("middle_manager/evaluations#new")
    end

    it "routes to #show" do
      expect(:get => "/middle_manager/evaluations/1").to route_to("middle_manager/evaluations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/middle_manager/evaluations/1/edit").to route_to("middle_manager/evaluations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/middle_manager/evaluations").to route_to("middle_manager/evaluations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/middle_manager/evaluations/1").to route_to("middle_manager/evaluations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/middle_manager/evaluations/1").to route_to("middle_manager/evaluations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/middle_manager/evaluations/1").to route_to("middle_manager/evaluations#destroy", :id => "1")
    end

  end
end
