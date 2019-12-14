FactoryBot.define do
  factory :attribute do
    request_method { nil }
    key { "MyString" }
    value { "MyString" }
    is_required { false }
    field_type { "MyString" }
  end
end
