require 'rails_helper'

describe 'RESET PASSWORD VALIDATION' do
  let(:headers) do
    {
      'ACCEPT'            => 'application/json',
      'HTTP_CONTENT_TYPE' => 'application/json'
    }
  end

  let(:password) { Faker::Internet.password }

  let!(:user) { create :user, password: password }

  let!(:reset_password) { create :reset_password, user: user }

  let(:path) { '/api/session/reset_passwords/validate' }

  context 'valid restore token' do
    let(:params) do
      {
        "token": reset_password.token,
        "email": reset_password.email
      }
    end

    before { post path, params: params, headers: headers }

    it do
      expect(response).to have_http_status :success
    end
  end

  context 'not valid restore token' do
    let(:params) do
      {
        "token": '12345678'
      }
    end

    before { post path, params: params, headers: headers }

    it do
      expect(response.content_type).to eq 'application/json'

      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
