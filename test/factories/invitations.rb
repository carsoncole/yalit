FactoryBot.define do
  factory :invitation do
    email { Faker::Internet.email }
    project
  end
end