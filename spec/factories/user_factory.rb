FactoryBot.define do
  factory :user, class: ApiSessionRecovering::User do
    password { Faker::Internet.password }
    email    { Faker::Internet.email }
  end
end
