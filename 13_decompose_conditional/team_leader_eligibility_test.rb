require_relative "../test_helper"
require_relative "team_leader_eligibility"

class TeamLeaderEligibilityTest < Minitest::Test
  def setup
    @checker = TeamLeaderEligibility.new
  end

  def test_eligible_when_all_criteria_met
    assert @checker.eligible?(eligible_volunteer)
  end

  def test_ineligible_when_too_new
    volunteer = eligible_volunteer.merge(years_serving: 1)

    refute @checker.eligible?(volunteer)
  end

  def test_ineligible_when_background_check_pending
    volunteer = eligible_volunteer.merge(background_check: "pending")

    refute @checker.eligible?(volunteer)
  end

  def test_ineligible_when_on_leave
    volunteer = eligible_volunteer.merge(on_leave: true)

    refute @checker.eligible?(volunteer)
  end

  def test_ineligible_when_training_incomplete
    volunteer = eligible_volunteer.merge(training_complete: false)

    refute @checker.eligible?(volunteer)
  end

  def test_ineligible_when_attendance_too_low
    volunteer = eligible_volunteer.merge(attendance_pct: 74)

    refute @checker.eligible?(volunteer)
  end

  def test_eligible_at_exactly_two_years
    volunteer = eligible_volunteer.merge(years_serving: 2)

    assert @checker.eligible?(volunteer)
  end

  def test_eligible_at_exactly_75_percent_attendance
    volunteer = eligible_volunteer.merge(attendance_pct: 75)

    assert @checker.eligible?(volunteer)
  end

  def test_reason_for_insufficient_tenure
    volunteer = eligible_volunteer.merge(years_serving: 1)

    assert_includes @checker.ineligible_reason(volunteer), "2 years"
  end

  def test_reason_for_failed_background_check
    volunteer = eligible_volunteer.merge(background_check: "failed")

    assert_includes @checker.ineligible_reason(volunteer), "Background check"
  end

  def test_reason_for_being_on_leave
    volunteer = eligible_volunteer.merge(on_leave: true)

    assert_includes @checker.ineligible_reason(volunteer), "leave"
  end

  def test_reason_for_incomplete_training
    volunteer = eligible_volunteer.merge(training_complete: false)

    assert_includes @checker.ineligible_reason(volunteer), "Training"
  end

  def test_reason_for_low_attendance
    volunteer = eligible_volunteer.merge(attendance_pct: 50)

    assert_includes @checker.ineligible_reason(volunteer), "75%"
  end

  private

  def eligible_volunteer
    {
      years_serving: 3,
      background_check: "cleared",
      on_leave: false,
      training_complete: true,
      attendance_pct: 90,
    }
  end
end
