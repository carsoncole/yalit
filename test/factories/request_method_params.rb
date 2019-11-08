FactoryBot.define do
  factory :request_method_param do
    request_method { nil }
    name { "MyString" }
    description { "MyString" }
    type { "" }
    is_required { false }
  end
end
