require 'rails_helper'

RSpec.describe "Staff::Evaluations", type: :request do
  describe "GET /staff_evaluations" do
    it "works! (now write some real specs)" do
      get staff_evaluations_path
      expect(response).to have_http_status(200)
    end
  end
end
