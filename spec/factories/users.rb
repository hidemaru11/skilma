FactoryBot.define do
  factory :user do
    email { "steven@example.com" }
    username { "steven" }
    password { "pass1234" }
    password_confirmation { "pass1234" }
  end
end
