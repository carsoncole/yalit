FactoryBot.define do
  factory :request_method do
    path { "/some/path/to/a/resource" }
    description { Faker::Lorem.sentences(number: 1) }
    verb { "get" }
    section
  end
end