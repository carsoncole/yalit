require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "new project gets default content" do
    project = create(:project, generate_default_content: true)
    assert project.chapters.any?
    assert_equal project.chapters.first.title, "Introduction"
  end
end
