FactoryBot.define do
  factory :user do
    email { "MyString@example.com" }
    password { "password" }
    projects {[FactoryBot.create(:project)]}
  end
end
