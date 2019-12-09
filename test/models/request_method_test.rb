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

  test "verb must be in list" do
    request_method = build(:request_method, verb: "GEL")
    assert_not request_method.save, "Saved with an unknown verb"
  end

  test "verb is upcased" do
    request_method = create(:request_method, verb: "gEt")
    assert_equal request_method.verb, "GET"

    request_method.update(verb: "get")
    assert_equal request_method.verb, "GET"
  end
end
