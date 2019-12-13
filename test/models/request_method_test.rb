require "test_helper"

class RequestMethodTest < ActiveSupport::TestCase
  test "factory is valid with defaults" do
    request_method = build(:request_method)
    assert request_method.save
  end

  test "path must be present" do
    request_method = build(:request_method, path: nil)
    assert_not request_method.save
  end

  test "description must be present" do
    request_method = build(:request_method, description: nil)
    assert_not request_method.save
  end

  test "verb must not be nil" do
    request_method = build(:request_method, verb: nil)
    assert_not request_method.save
  end

  test "verb must be present" do
    request_method = build(:request_method, verb: "")
    assert_not request_method.save
  end

  test "verb not in list" do
    request_method = build(:request_method, verb: "GEL")
    assert_not request_method.save, "Saved with an unknown verb"
  end

  test "verb must be in list" do
    request_method = build(:request_method, verb: "GET")
    assert request_method.save, "Did not save an acceptable verb"
  end

  test "verb is auto-upcased" do
    request_method = create(:request_method, verb: "gEt")
    assert_equal request_method.verb, "GET"

    request_method.update(verb: "get")
    assert_equal request_method.verb, "GET"
  end

  test "full path substitutes existing single param" do
    param = create(:parameter, key: "user_uuid")
    request_method = param.request_method
    request_method.update(path: "/users/{user_uuid}")
    assert_equal "/users/#{param.value}", request_method.full_path
  end

  test "full path substitutes multiple params" do
    param_1 = create(:parameter, key: "user_uuid")
    request_method = param_1.request_method
    param_2 = create(:parameter, request_method: request_method, key: "id")
    param_3 = create(:parameter, request_method: request_method, key: "post_id")
    request_method.update(path: "/users/{user_uuid}/posts/{post_id}/months/{id}")
    path = "/users/#{param_1.value}/posts/#{param_3.value}/months/#{param_2.value}"
    assert_equal path, request_method.full_path
  end

  test "parameters hash is a hash" do
    param_1 = create(:parameter)
    request_method = param_1.request_method
    param_2 = create(:parameter, request_method: request_method)

    assert_equal Hash, request_method.parameters_hash.class
    assert_equal request_method.parameters_hash, { param_1.key.to_sym => param_1.value, param_2.key.to_sym => param_2.value }
  end
end
