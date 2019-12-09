require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  test "factory is valid with defaults" do
    invite = build(:invitation)
    assert invite.valid?, "factory built an invite without minimum attributes"
  end

  test "email must be present" do
    invite = build(:invitation, email: nil)
    assert_not invite.save, "Saved an invite without an email"
  end

  test "role must be present" do
    invite = build(:invitation, role: nil)
    assert_not invite.save, "Saved an invite without a role"
  end

  test "project must be present" do
    invite = build(:invitation, project: nil)
    assert_not invite.save, "Saved an invite without a project"
  end

  test "should have unique email invites on same project" do
    invite_1 = create(:invitation)
    invite_2 = build(:invitation, project_id: invite_1.project_id, email: invite_1.email)
    assert_not invite_2.save, "Saved invite with email already existing in invites"
  end
end
