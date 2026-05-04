require_relative "../test_helper"
require_relative "volunteer_schedule"

class VolunteerScheduleTest < Minitest::Test
  def test_includes_role_in_summary
    schedule = build_schedule(role: "Worship Team", needed: 5, volunteers: confirmed(5))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "Worship Team"
  end

  def test_shows_confirmed_count
    schedule = build_schedule(needed: 5, volunteers: confirmed(3) + declined(2))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "3/"
  end

  def test_shows_needed_count
    schedule = build_schedule(needed: 8, volunteers: confirmed(8))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "/8"
  end

  def test_shows_coverage_percentage
    schedule = build_schedule(needed: 4, volunteers: confirmed(3))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "(75%)"
  end

  def test_fully_staffed_when_confirmed_equals_needed
    schedule = build_schedule(needed: 4, volunteers: confirmed(4))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "Fully staffed"
  end

  def test_fully_staffed_when_confirmed_exceeds_needed
    schedule = build_schedule(needed: 4, volunteers: confirmed(6))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "Fully staffed"
  end

  def test_partially_staffed_at_sixty_percent
    schedule = build_schedule(needed: 10, volunteers: confirmed(6))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "Partially staffed"
  end

  def test_partially_staffed_below_full
    schedule = build_schedule(needed: 10, volunteers: confirmed(7))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "Partially staffed"
  end

  def test_understaffed_below_sixty_percent
    schedule = build_schedule(needed: 10, volunteers: confirmed(5))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "Understaffed"
  end

  def test_understaffed_with_no_confirmed
    schedule = build_schedule(needed: 4, volunteers: declined(4))

    assert_includes VolunteerSchedule.new(schedule).status_summary, "Understaffed"
  end

  def test_fully_staffed_when_no_volunteers_needed
    schedule = build_schedule(needed: 0, volunteers: [])

    assert_includes VolunteerSchedule.new(schedule).status_summary, "Fully staffed"
  end

  private

  def build_schedule(role: "Ushers", needed:, volunteers:)
    { role: role, needed: needed, volunteers: volunteers }
  end

  def confirmed(count)
    Array.new(count) { { status: "confirmed" } }
  end

  def declined(count)
    Array.new(count) { { status: "declined" } }
  end
end
