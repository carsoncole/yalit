require "test_helper"

class ServerTest < ActiveSupport::TestCase
  test "factory is valid with defaults" do
    invite = build(:invitation)
    assert invite.valid?, "factory built an invite without minimum attributes"
  end

  test "url must be present" do
    server = build(:server, url: nil)
    assert_not server.save, "Saved a server without a url"
  end

  test "description must be present" do
    server = build(:server, description: nil)
    assert_not server.save, "Saved a server without a description"
  end
end
