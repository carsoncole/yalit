require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "new project gets default content" do
    project = create(:project, generate_default_content: true)
    assert project.chapters.any?
    assert_equal project.chapters.first.title, "Introduction"
  end

  test "hostnames are validated" do
    project = build(:project)
    project.host_name = "https://something.com"
    assert_not project.valid?

    project.host_name = "http://something.com"
    assert_not project.valid?

    project.host_name = "somethi#ng.com"
    assert_not project.valid?

    project.host_name = "somethingcom"
    assert_not project.valid?

    project.host_name = "something.com"
    assert project.valid?
  end
end
