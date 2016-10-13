require 'rails_helper'

RSpec.describe "MiddleManager::SelfEvaluations", type: :request do
  describe "GET /middle_manager_self_evaluations" do
    it "works! (now write some real specs)" do
      get middle_manager_self_evaluations_path
      expect(response).to have_http_status(200)
    end
  end
end
