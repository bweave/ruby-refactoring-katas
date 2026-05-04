require_relative "../test_helper"
require_relative "volunteer_roster"

class VolunteerRosterTest < Minitest::Test
  def test_confirmed_names_returns_full_names_of_confirmed_volunteers
    roster = VolunteerRoster.new([confirmed("Ada", "Gomez"), declined("Bo", "Lee")])

    assert_equal ["Ada Gomez"], roster.confirmed_names
  end

  def test_confirmed_names_excludes_declined
    roster = VolunteerRoster.new([declined("Bo", "Lee"), confirmed("Zoe", "Park")])

    assert_equal ["Zoe Park"], roster.confirmed_names
  end

  def test_confirmed_names_returns_all_confirmed
    roster =
      VolunteerRoster.new(
        [confirmed("Ada", "Gomez"), confirmed("Sam", "Ruiz"), declined("Bo", "Lee")],
      )

    assert_equal ["Ada Gomez", "Sam Ruiz"], roster.confirmed_names
  end

  def test_confirmed_names_empty_when_none_confirmed
    roster = VolunteerRoster.new([declined("Bo", "Lee")])

    assert_empty roster.confirmed_names
  end

  def test_team_totals_counts_by_team
    roster =
      VolunteerRoster.new(
        [volunteer(team: "Worship"), volunteer(team: "Worship"), volunteer(team: "Ushers")],
      )

    assert_equal({ "Worship" => 2, "Ushers" => 1 }, roster.team_totals)
  end

  def test_team_totals_single_volunteer
    roster = VolunteerRoster.new([volunteer(team: "Parking")])

    assert_equal({ "Parking" => 1 }, roster.team_totals)
  end

  def test_any_declined_true_when_someone_declined
    roster = VolunteerRoster.new([confirmed("Ada", "Gomez"), declined("Bo", "Lee")])

    assert roster.any_declined?
  end

  def test_any_declined_false_when_all_confirmed
    roster = VolunteerRoster.new([confirmed("Ada", "Gomez"), confirmed("Zoe", "Park")])

    refute roster.any_declined?
  end

  def test_total_hours_sums_all_hours
    roster = VolunteerRoster.new([volunteer(hours: 3), volunteer(hours: 2), volunteer(hours: 4)])

    assert_equal 9, roster.total_hours
  end

  def test_total_hours_skips_volunteers_without_hours
    roster = VolunteerRoster.new([volunteer(hours: 3), volunteer(hours: nil)])

    assert_equal 3, roster.total_hours
  end

  def test_total_hours_zero_when_no_hours_recorded
    roster = VolunteerRoster.new([volunteer(hours: nil)])

    assert_equal 0, roster.total_hours
  end

  private

  def confirmed(first, last)
    { first_name: first, last_name: last, status: "confirmed", team: "Worship", hours: 2 }
  end

  def declined(first, last)
    { first_name: first, last_name: last, status: "declined", team: "Worship", hours: nil }
  end

  def volunteer(overrides = {})
    { first_name: "Sam", last_name: "Reed", status: "confirmed", team: "Ushers", hours: 2 }.merge(
      overrides,
    )
  end
end
