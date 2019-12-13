FactoryBot.define do
  factory :parameter do
    key { "#{ Faker::Creature::Animal.name.downcase }_id" }
    value { Faker::Alphanumeric.alphanumeric(number: 15) }
    request_method
  end
end
