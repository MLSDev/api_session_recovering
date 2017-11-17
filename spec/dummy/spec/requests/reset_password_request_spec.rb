require 'rails_helper'

describe 'RESET PASSWORD' do
  let(:headers) do
    {
      'ACCEPT'            => 'application/json',
      'HTTP_CONTENT_TYPE' => 'application/json'
    }
  end

  let(:password) { Faker::Internet.password }

  let(:user) { create :user, password: password }

  let(:restore_password) { create :restore_password, user: user }

  let(:path) { '/api/session/reset_password' }

  context 'valid restore token' do
    let(:params) do
      {
        "reset_password": {
          "token":                 restore_password.token,
          "password":              'q7654321',
          "password_confirmation": 'q7654321'
        }
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
        "reset_password": {
          "token":                 '12345678',
          "password":              'q7654321',
          "password_confirmation": 'q7654321'
        }
      }
    end

    before { post path, params: params, headers: headers }

    it do
      expect(response.content_type).to eq 'application/json'

      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
