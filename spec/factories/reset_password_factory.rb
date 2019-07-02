FactoryBot.define do
  factory :reset_password, class: ApiSessionRecovering::ResetPassword do
    frontend_path { Faker::Internet.url }
    remote_ip     { Faker::Internet.ip_v4_address }
    email         { Faker::Internet.email }
    token         { SecureRandom.urlsafe_base64 }
    expire_at     { 1.day.from_now.utc }
  end
end
