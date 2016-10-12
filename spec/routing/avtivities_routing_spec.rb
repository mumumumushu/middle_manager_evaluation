require "rails_helper"

RSpec.describe AvtivitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/avtivities").to route_to("avtivities#index")
    end

    it "routes to #new" do
      expect(:get => "/avtivities/new").to route_to("avtivities#new")
    end

    it "routes to #show" do
      expect(:get => "/avtivities/1").to route_to("avtivities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/avtivities/1/edit").to route_to("avtivities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/avtivities").to route_to("avtivities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/avtivities/1").to route_to("avtivities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/avtivities/1").to route_to("avtivities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/avtivities/1").to route_to("avtivities#destroy", :id => "1")
    end

  end
end
