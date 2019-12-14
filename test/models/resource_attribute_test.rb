require "test_helper"

class ResourceAttributeTest < ActiveSupport::TestCase
  # test "factory is valid with defaults" do
  #   resource_attribute = build(:resource_attribute)
  #   assert resource_attribute.save
  # end

  # test "path must be present" do
  #   resource_attribute = build(:resource_attribute, path: nil)
  #   assert_not resource_attribute.save
  # end

  # test "description must be present" do
  #   resource_attribute = build(:resource_attribute, description: nil)
  #   assert_not resource_attribute.save
  # end

  # test "verb must not be nil" do
  #   resource_attribute = build(:resource_attribute, verb: nil)
  #   assert_not resource_attribute.save
  # end

  # test "verb must be present" do
  #   resource_attribute = build(:resource_attribute, verb: "")
  #   assert_not resource_attribute.save
  # end

  # test "verb not in list" do
  #   resource_attribute = build(:resource_attribute, verb: "GEL")
  #   assert_not resource_attribute.save, "Saved with an unknown verb"
  # end

  # test "verb must be in list" do
  #   resource_attribute = build(:resource_attribute, verb: "GET")
  #   assert resource_attribute.save, "Did not save an acceptable verb"
  # end

  # test "verb is auto-upcased" do
  #   resource_attribute = create(:resource_attribute, verb: "gEt")
  #   assert_equal resource_attribute.verb, "GET"

  #   resource_attribute.update(verb: "get")
  #   assert_equal resource_attribute.verb, "GET"
  # end

  # test "full path substitutes existing single param" do
  #   param = create(:parameter, key: "user_uuid")
  #   resource_attribute = param.resource_attribute
  #   resource_attribute.update(path: "/users/{user_uuid}")
  #   assert_equal "/users/#{param.value}", resource_attribute.full_path
  # end

  # test "full path substitutes multiple params" do
  #   param_1 = create(:parameter, key: "user_uuid")
  #   resource_attribute = param_1.resource_attribute
  #   param_2 = create(:parameter, resource_attribute: resource_attribute, key: "id")
  #   param_3 = create(:parameter, resource_attribute: resource_attribute, key: "post_id")
  #   resource_attribute.update(path: "/users/{user_uuid}/posts/{post_id}/months/{id}")
  #   path = "/users/#{param_1.value}/posts/#{param_3.value}/months/#{param_2.value}"
  #   assert_equal path, resource_attribute.full_path
  # end

  # test "parameters hash is a hash" do
  #   param_1 = create(:parameter)
  #   resource_attribute = param_1.resource_attribute
  #   param_2 = create(:parameter, resource_attribute: resource_attribute)

  #   assert_equal Hash, resource_attribute.parameters_hash.class
  #   assert_equal resource_attribute.parameters_hash, { param_1.key.to_sym => param_1.value, param_2.key.to_sym => param_2.value }
  # end
end
