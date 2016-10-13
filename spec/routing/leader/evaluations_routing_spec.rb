require "rails_helper"

RSpec.describe Leader::EvaluationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/leader/evaluations").to route_to("leader/evaluations#index")
    end

    it "routes to #new" do
      expect(:get => "/leader/evaluations/new").to route_to("leader/evaluations#new")
    end

    it "routes to #show" do
      expect(:get => "/leader/evaluations/1").to route_to("leader/evaluations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/leader/evaluations/1/edit").to route_to("leader/evaluations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/leader/evaluations").to route_to("leader/evaluations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/leader/evaluations/1").to route_to("leader/evaluations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/leader/evaluations/1").to route_to("leader/evaluations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/leader/evaluations/1").to route_to("leader/evaluations#destroy", :id => "1")
    end

  end
end
