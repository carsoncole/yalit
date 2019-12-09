require "test_helper"

class ChaptersControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @chapter = chapters(:one)
  # end

  test "should get new" do
    get new_chapter_url
    assert_response :redirect
  end

  # test "should not show a chapter not logged in or on hosted" do
  #   chapter = create(:chapter)
  #   assert chapter.valid?
  #   get chapter_url(chapter)
  #   assert_redirected_to sign_in_url
  # end

  # test "should get chapter" do
  #   get chapter_url(@chapter)
  #   assert_response :success
  # end

  # test "should create chapter" do
  #   assert_difference('Chapter.count') do
  #     post chapters_url, params: { chapter: { content: @chapter.content, project_id: @chapter.project_id, title: @chapter.title } }
  #   end

  #   assert_redirected_to chapter_url(Chapter.last)
  # end

  # test "should get edit" do
  #   get edit_chapter_url(@chapter)
  #   assert_response :success
  # end

  # test "should update chapter" do
  #   patch chapter_url(@chapter), params: { chapter: { content: @chapter.content, project_id: @chapter.project_id, title: @chapter.title } }
  #   assert_redirected_to chapter_url(@chapter)
  # end

  # test "should destroy chapter" do
  #   assert_difference('Chapter.count', -1) do
  #     delete chapter_url(@chapter)
  #   end

  #   assert_redirected_to chapters_url
  # end
end
