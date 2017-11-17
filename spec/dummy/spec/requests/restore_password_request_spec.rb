require 'rails_helper'

describe 'RESTORE PASSWORD' do
  let(:headers) do
    {
      'HTTP_ACCEPT'       => 'application/json',
      'HTTP_CONTENT_TYPE' => 'application/json'
    }
  end

  let(:token) { SecureRandom.uuid }

  let!(:user) { create :user }

  let!(:preference) { ApiSessionRecovering::Preference.first_or_create! }

  let(:path) { '/api/session_recovering/restore_password' }

  context 'valid restore token' do
    let(:params) do
      {
        "restore_password": {
          "email": user.email,
        }
      }
    end

    before { post path, params: params, headers: headers }

    it do
      expect(response).to have_http_status :success
    end
  end

  context 'limit is exceeded' do
    let(:params) do
      {
        "restore_password": {
          "token": token,
          "email": user.email
        }
      }
    end

    let(:remote_ip) { Faker::Internet.ip_v4_address }

    before { preference.update! allowed_password_reset_per_day_count: 0 }

    before { post path, params: params, headers: headers }

    it do
      expect(response.content_type).to eq 'application/json'

      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
