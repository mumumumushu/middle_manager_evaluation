require 'rails_helper'

RSpec.describe "SelfEvaluations", type: :request do
  describe "GET /self_evaluations" do
    it "works! (now write some real specs)" do
      get self_evaluations_path
      expect(response).to have_http_status(200)
    end
  end
end
