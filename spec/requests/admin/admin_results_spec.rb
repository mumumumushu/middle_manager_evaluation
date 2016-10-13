require 'rails_helper'

RSpec.describe "Admin::Results", type: :request do
  describe "GET /admin_results" do
    it "works! (now write some real specs)" do
      get admin_results_path
      expect(response).to have_http_status(200)
    end
  end
end
