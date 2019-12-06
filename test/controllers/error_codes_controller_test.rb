require 'test_helper'

class ErrorCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get error_codes_index_url
    assert_response :success
  end

  test "should get show" do
    get error_codes_show_url
    assert_response :success
  end

  test "should get edit" do
    get error_codes_edit_url
    assert_response :success
  end

  test "should get update" do
    get error_codes_update_url
    assert_response :success
  end

  test "should get new" do
    get error_codes_new_url
    assert_response :success
  end

  test "should get create" do
    get error_codes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get error_codes_destroy_url
    assert_response :success
  end

end
