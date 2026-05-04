require_relative "../test_helper"
require_relative "service_team"

class ServiceTeamTest < Minitest::Test
  def test_add_increases_size
    team = ServiceTeam.new("Worship")
    team.add(member("Ada"))

    assert_equal 1, team.size
  end

  def test_size_reflects_all_added_members
    team = ServiceTeam.new("Worship")
    team.add(member("Ada"))
    team.add(member("Bo"))
    team.add(member("Cal"))

    assert_equal 3, team.size
  end

  def test_confirmed_returns_confirmed_members
    team = ServiceTeam.new("Ushers")
    team.add(member("Ada", status: "confirmed"))
    team.add(member("Bo", status: "declined"))

    assert_equal 1, team.confirmed.size
    assert_equal "confirmed", team.confirmed.first[:status]
  end

  def test_confirmed_excludes_declined
    team = ServiceTeam.new("Ushers")
    team.add(member("Bo", status: "declined"))

    assert_empty team.confirmed
  end

  def test_leaders_returns_members_with_leader_role
    team = ServiceTeam.new("Worship")
    team.add(member("Ada", role: "leader"))
    team.add(member("Bo", role: "member"))

    assert_equal 1, team.leaders.size
  end

  def test_leaders_empty_when_no_leaders
    team = ServiceTeam.new("Worship")
    team.add(member("Bo", role: "member"))

    assert_empty team.leaders
  end

  def test_roster_returns_sorted_confirmed_names
    team = ServiceTeam.new("Parking")
    team.add(member("Zoe", status: "confirmed"))
    team.add(member("Ada", status: "confirmed"))
    team.add(member("Bo", status: "declined"))

    assert_equal %w[Ada Zoe], team.roster
  end

  def test_roster_excludes_declined
    team = ServiceTeam.new("Parking")
    team.add(member("Bo", status: "declined"))

    assert_empty team.roster
  end

  def test_name_is_readable
    team = ServiceTeam.new("Greeters")

    assert_equal "Greeters", team.name
  end

  private

  def member(name, status: "confirmed", role: "member")
    { name: name, status: status, role: role }
  end
end
