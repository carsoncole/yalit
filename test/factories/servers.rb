FactoryBot.define do
  factory :server do
    project
    url { Faker::Internet.url }
    description { Faker::Lorem.sentences(number: 2) }
  end
end