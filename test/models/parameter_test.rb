require 'test_helper'

#TODO Parameter tests
class ParameterTest < ActiveSupport::TestCase
  # test "key must be present" do
  #   parameter = build(:parameter, key: nil)
  #   assert_not parameter.save, "Saved a parameter without a key"
  # end

  # test "value must be present" do
  #   parameter = build(:parameter, value: nil)
  #   assert_not parameter.save, "Saved a parameter without a value"
  # end

  # test "key must be unique for request methods" do
  #   request_method = create(:request_method)
  #   create(:parameter, key: "user_id", request_method_id: request_method.id)
  #   parameter = build(:parameter, key: "user_id", request_method_id: request_method.id)
  #   assert_not parameter.save, "Saved a non-unique parameter key within a request method"
  # end
end
