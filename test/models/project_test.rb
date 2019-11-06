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

    # development site work
    project.host_name = "localhost:3000"
    assert project.valid?
  end

  test "getting Heroku hostname nil status with no domain" do
    project = build(:project)
    assert_not project.is_hosted
    assert_nil project.heroku_get_domain_status!
  end

  test "generating of default content" do
    project = create(:project, generate_default_content: false)
    assert project.chapters.empty?

    project = create(:project, generate_default_content: true)
    assert project.chapters.any?
  end

  test "basic validations are met" do
    project = build(:project, name: nil)
    assert_not project.valid?

  end
end
