require "test_helper"

class ChapterTest < ActiveSupport::TestCase
  test "creating a new chapter with a factory" do
    chapter = build(:chapter)
    assert chapter.save
  end

  test "title must be present" do
    chapter = build(:chapter, title: nil)
    assert_not chapter.save, "Saved a chapter without a title"
  end

  test "chapters should be created with sequential ranks" do
    chapter = create(:chapter)
    chapter2 = create(:chapter, project_id: chapter.project_id)
    assert chapter2.rank == chapter.rank + 1
  end
end
