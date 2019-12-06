FactoryBot.define do
  factory :error_code do
    section { nil }
    title { "MyString" }
    http_status_code { 1 }
    custom_status_code { 1 }
    message { "MyString" }
  end
end
