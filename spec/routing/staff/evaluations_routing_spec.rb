require "rails_helper"

RSpec.describe Staff::EvaluationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/staff/evaluations").to route_to("staff/evaluations#index")
    end

    it "routes to #new" do
      expect(:get => "/staff/evaluations/new").to route_to("staff/evaluations#new")
    end

    it "routes to #show" do
      expect(:get => "/staff/evaluations/1").to route_to("staff/evaluations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/staff/evaluations/1/edit").to route_to("staff/evaluations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/staff/evaluations").to route_to("staff/evaluations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/staff/evaluations/1").to route_to("staff/evaluations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/staff/evaluations/1").to route_to("staff/evaluations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/staff/evaluations/1").to route_to("staff/evaluations#destroy", :id => "1")
    end

  end
end
