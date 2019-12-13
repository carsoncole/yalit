require "test_helper"

#TODO Tests
class SchemaTest < ActiveSupport::TestCase
  
  test "schema object is created" do
    project = build(:project)
    assert_equal project.schema.class, Schema

    assert_equal project.schema.open_api.class, Hash
    assert project.schema.open_api[:openapi]
  end
end
