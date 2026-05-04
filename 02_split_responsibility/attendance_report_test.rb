require_relative "../test_helper"
require_relative "attendance_report"

class AttendanceReportTest < Minitest::Test
  def setup
    @report = AttendanceReport.new
    @group = { name: "Student Ministry" }
  end

  def test_includes_group_name
    result = @report.summary(@group, build_attendances(present: 3, absent: 1))

    assert_includes result, "Student Ministry"
  end

  def test_shows_present_count_and_total
    result = @report.summary(@group, build_attendances(present: 8, absent: 2))

    assert_includes result, "Present: 8 of 10"
  end

  def test_shows_absent_count
    result = @report.summary(@group, build_attendances(present: 8, absent: 2))

    assert_includes result, "Absent: 2"
  end

  def test_shows_attendance_rate
    result = @report.summary(@group, build_attendances(present: 8, absent: 2))

    assert_includes result, "80%"
  end

  def test_rounds_attendance_rate
    result = @report.summary(@group, build_attendances(present: 1, absent: 2))

    assert_includes result, "33%"
  end

  def test_first_timers_shown_when_present
    attendances = build_attendances(present: 5) + [{ status: "present", first_time: true }]

    result = @report.summary(@group, attendances)

    assert_includes result, "First-time visitors: 1"
  end

  def test_first_timers_hidden_when_none
    result = @report.summary(@group, build_attendances(present: 5))

    refute_includes result, "First-time"
  end

  def test_strong_attendance_status
    result = @report.summary(@group, build_attendances(present: 9, absent: 1))

    assert_includes result, "Strong"
  end

  def test_needs_attention_status
    result = @report.summary(@group, build_attendances(present: 7, absent: 3))

    assert_includes result, "Needs attention"
  end

  def test_follow_up_required_status
    result = @report.summary(@group, build_attendances(present: 4, absent: 6))

    assert_includes result, "Follow up required"
  end

  def test_handles_empty_attendances
    result = @report.summary(@group, [])

    assert_includes result, "Present: 0 of 0 (0%)"
  end

  private

  def build_attendances(present: 0, absent: 0)
    Array.new(present) { { status: "present", first_time: false } } +
      Array.new(absent) { { status: "absent", first_time: false } }
  end
end
