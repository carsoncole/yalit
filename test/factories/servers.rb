FactoryBot.define do
  factory :server do
    project
    url { "https://postman-echo.com/get" }
    description { "This is a test server hosted by Postman." }
  end
end