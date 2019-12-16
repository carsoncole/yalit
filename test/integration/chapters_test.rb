require 'test_helper'

class ChaptersTest < ActionDispatch::IntegrationTest
  test "should redirect on new and not logged on" do
    get new_chapter_url
    assert_response :redirect
  end
end
