require_relative "../test_helper"
require_relative "volunteer_roster"

class VolunteerPoolTest < Minitest::Test
  VOLUNTEERS = [
    {name: "Alice", team: "Worship", available: true, qualified: true, first_timer: false},
    {name: "Bob", team: "Worship", available: false, qualified: true, first_timer: false},
    {name: "Carol", team: "Worship", available: true, qualified: false, first_timer: true},
    {name: "Dave", team: "Kids", available: true, qualified: true, first_timer: false},
    {name: "Eve", team: "Kids", available: true, qualified: true, first_timer: true},
  ].freeze

  def test_available_for_team
    roster = VolunteerPool.new(VOLUNTEERS)

    names = roster.available_for("Worship").map { |v| v[:name] }
    assert_equal ["Alice", "Carol"], names
  end

  def test_qualified_for_team
    roster = VolunteerPool.new(VOLUNTEERS)

    names = roster.qualified_for("Worship").map { |v| v[:name] }
    assert_equal ["Alice", "Bob"], names
  end

  def test_ready_for_team
    roster = VolunteerPool.new(VOLUNTEERS)

    names = roster.ready_for("Worship").map { |v| v[:name] }
    assert_equal ["Alice"], names
  end

  def test_first_time_for_team
    roster = VolunteerPool.new(VOLUNTEERS)

    names = roster.first_time_for("Kids").map { |v| v[:name] }
    assert_equal ["Eve"], names
  end

  def test_names_for_team
    roster = VolunteerPool.new(VOLUNTEERS)

    assert_equal ["Alice", "Bob", "Carol"], roster.names_for("Worship")
  end

  def test_ready_for_different_team
    roster = VolunteerPool.new(VOLUNTEERS)

    names = roster.ready_for("Kids").map { |v| v[:name] }
    assert_equal ["Dave", "Eve"], names
  end

  def test_empty_team
    roster = VolunteerPool.new(VOLUNTEERS)

    assert_equal [], roster.available_for("Parking")
  end
end
