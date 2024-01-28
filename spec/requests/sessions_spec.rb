require 'rails_helper'

describe 'Api::SessionesController', type: :request do
  context 'when admin is not logged in' do
    let(:email) { 'test@test.com' }
    let(:password) { 'password' }
    let(:admin) { create(:admin, email: email, password: password) }

    it 'logs in an admin' do
      post '/api/sessions/login', { email: admin.email, password: admin.password }
      expect(response).to be_success
      response_body = JSON.parse(response.body)
      expect(response_body['token']).to eq(admin.generate_jwt)
    end

    it 'does not log in an admin with invalid credentials' do
      post '/api/sessions/login', { email: admin.email, password: 'wrong_password' }
      expect(response.status).to eq(401)
    end
  end
end
