require 'rails_helper'

RSpec.describe "Avtivities", type: :request do
  describe "GET /avtivities" do
    it "works! (now write some real specs)" do
      get avtivities_path
      expect(response).to have_http_status(200)
    end
  end
end
