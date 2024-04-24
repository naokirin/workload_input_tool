require 'rails_helper'

RSpec.describe "WorkloadPoints", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/workload_point/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
