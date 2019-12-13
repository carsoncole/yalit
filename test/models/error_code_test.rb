require 'test_helper'

class ErrorCodeTest < ActiveSupport::TestCase
  test "default factory works" do
    assert create(:error_code)
  end
end
