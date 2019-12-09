require "test_helper"

#FIXME Fix hosting-related tests
class ProjectTest < ActiveSupport::TestCase
  def setup
    @project = build(:project)
  end

  test "factory is valid with defaults" do
    assert @project.valid?, "factory built a project without minimum attributes"
  end

  test "title must be present" do
    @project.title = nil
    assert_not @project.save, "Saved a project without a name"
  end

  test "color must be present" do
    @project.color = nil
    assert_not @project.save, "Saved a project without a color"
  end

  test "color must be correct HEX preceeded by #" do
    @project.color = "123"
    assert_not @project.save, "Saved a project with a bad Hex value--not preceeded by #"
  end

  test "color must be correct HEX with hex values" do
    @project.color = "#jjj"
    assert_not @project.save, "Saved a project with a bad non-Hex value"
  end

  test "is_hosted only allowed with domain" do
    @project.is_hosted = true
    assert_not @project.save, "Allowed is_hosted without a domain"
  end

  test "only allowing unique host names" do
    @project.host_name = "example.com"
    @project.save
    project2 = build(:project, host_name: "example.com")
    assert_not project2.save, "A non-unique host_name was saved"
  end

  test "host name should not include a protocol" do
    @project.host_name = "https://example.com"
    assert_not @project.save, "Saved with a protocol"
  end

  test "host name should include a domain" do
    @project.host_name = "examplecom"
    assert_not @project.save, "Saved with a protocol"
  end

  test "host name should allow for localhost" do
    @project.host_name = "localhost:3000"
    assert @project.save, "Would not allow saving Localhost:3000"
  end

  test "host name should not have any special chars" do
    @project.host_name = "exam!ple.com"
    assert_not @project.save, "Saved with a special character"
  end

  test "generating of default content" do
    project = create(:project, generate_default_content: false)
    assert project.chapters.empty?

    project = create(:project, generate_default_content: true)
    assert project.chapters.any?
    assert_equal project.chapters.first.title, "Introduction"
  end

  # test "changing host_name should remove hosting" do
  #   project = create(:project, is_hosted: true, host_name: "example.com")
  #   assert project.update(host_name: 'newexample.com')
  #   assert_not project.reload.is_hosted
  # end

  # test "new project gets default content" do
  #   project = create(:project, generate_default_content: true)

  # end

  # test "getting Heroku hostname nil status with no domain" do
  #   project = build(:project)
  #   assert_not project.is_hosted
  #   assert_nil project.heroku_get_domain_status!
  # end
end
