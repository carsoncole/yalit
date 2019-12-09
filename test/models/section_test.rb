require "test_helper"

class SectionTest < ActiveSupport::TestCase

  test "sections should be created with sequential ranks" do
    section = create(:section)
    section2 = create(:section, chapter_id: section.chapter_id)
    assert section2.rank == section.rank + 1
  end
end
