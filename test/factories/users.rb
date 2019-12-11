FactoryBot.define do
  factory :user do
    email { "MyString@grade.us" }
    password { "password" }
    is_beta_user { true }
  end
end
