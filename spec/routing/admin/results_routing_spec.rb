require "rails_helper"

RSpec.describe Admin::ResultsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/results").to route_to("admin/results#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/results/new").to route_to("admin/results#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/results/1").to route_to("admin/results#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/results/1/edit").to route_to("admin/results#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/results").to route_to("admin/results#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/results/1").to route_to("admin/results#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/results/1").to route_to("admin/results#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/results/1").to route_to("admin/results#destroy", :id => "1")
    end

  end
end
