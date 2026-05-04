require_relative "../test_helper"
require_relative "group_report"

class GroupReportTest < Minitest::Test
  def setup
    @report = GroupReport.new
  end

  def test_includes_group_name
    group = Group.new(name: "Young Adults", member_count: 20, inactive_count: 4)

    assert_includes @report.membership_summary(group), "Young Adults"
  end

  def test_shows_active_count
    group = Group.new(name: "Worship Team", member_count: 12, inactive_count: 3)

    assert_includes @report.membership_summary(group), "9 active"
  end

  def test_shows_total_member_count
    group = Group.new(name: "Worship Team", member_count: 12, inactive_count: 3)

    assert_includes @report.membership_summary(group), "of 12"
  end

  def test_shows_active_percentage
    group = Group.new(name: "Worship Team", member_count: 12, inactive_count: 3)

    assert_includes @report.membership_summary(group), "(75%)"
  end

  def test_rounds_percentage
    group = Group.new(name: "Ushers", member_count: 3, inactive_count: 1)

    assert_includes @report.membership_summary(group), "(67%)"
  end

  def test_all_members_active
    group = Group.new(name: "Choir", member_count: 8, inactive_count: 0)

    assert_includes @report.membership_summary(group), "8 active of 8 (100%)"
  end

  def test_no_members_shows_zero_percent
    group = Group.new(name: "New Group", member_count: 0, inactive_count: 0)

    assert_includes @report.membership_summary(group), "(0%)"
  end

  def test_two_groups_are_independent
    small = Group.new(name: "Prayer Circle", member_count: 5, inactive_count: 1)
    large = Group.new(name: "Kids Ministry", member_count: 40, inactive_count: 10)

    assert_includes @report.membership_summary(small), "Prayer Circle"
    assert_includes @report.membership_summary(large), "Kids Ministry"
  end
end
