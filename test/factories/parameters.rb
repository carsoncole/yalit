FactoryBot.define do
  factory :parameter do
    key { "#{ Faker::Creature::Animal.name.downcase }_id" }
    value { Faker::Number.within(range: 1..1000000) }
    request_method
  end
end
