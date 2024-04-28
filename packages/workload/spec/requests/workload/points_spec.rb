# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Workload::Points', type: :request do
  describe 'GET /index' do
    context 'when user is not signed in' do
      it 'redirect to signin page' do
        get workload_points_path
        expect(response).to redirect_to new_user_account_session_path
      end
    end

    context 'when user is signed in' do
      it 'returns http success' do
        user = create(:user_account_record)
        user.confirm
        sign_in user
        get workload_points_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
