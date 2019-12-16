require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "clearance/test_unit"

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  # Changed this to 1 due to SimpleCov not working
  parallelize(workers: 1) #:number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def martech_email
    Faker::Name.first_name + "@" + User::MARTECH_DOMAINS.sample
  end
  # Add more helper methods to be used by all tests here...
end
