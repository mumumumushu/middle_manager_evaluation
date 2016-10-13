require 'rails_helper'

RSpec.describe "Leader::Evaluations", type: :request do
  describe "GET /leader_evaluations" do
    it "works! (now write some real specs)" do
      get leader_evaluations_path
      expect(response).to have_http_status(200)
    end
  end
end
