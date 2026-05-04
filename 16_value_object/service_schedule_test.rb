require_relative "../test_helper"
require_relative "service_schedule"

class ServiceScheduleTest < Minitest::Test
  CHICAGO = "America/Chicago"
  NEW_YORK = "America/New_York"

  def test_displays_am_time
    schedule = ServiceSchedule.new([{name: "Early", day: "Sunday", time: "08:00", zone: CHICAGO}])

    assert_equal ["Early: Sunday 8:00 AM CT"], schedule.display
  end

  def test_displays_pm_time
    schedule = ServiceSchedule.new([{name: "Evening", day: "Sunday", time: "18:30", zone: NEW_YORK}])

    assert_equal ["Evening: Sunday 6:30 PM ET"], schedule.display
  end

  def test_displays_noon
    schedule = ServiceSchedule.new([{name: "Noon", day: "Saturday", time: "12:00", zone: CHICAGO}])

    assert_equal ["Noon: Saturday 12:00 PM CT"], schedule.display
  end

  def test_displays_multiple_services
    schedule = ServiceSchedule.new([
      {name: "Traditional", day: "Sunday", time: "08:00", zone: CHICAGO},
      {name: "Contemporary", day: "Sunday", time: "10:30", zone: CHICAGO},
    ])

    assert_equal [
      "Traditional: Sunday 8:00 AM CT",
      "Contemporary: Sunday 10:30 AM CT",
    ], schedule.display
  end

  def test_same_slot_when_all_fields_match
    a = {name: "A", day: "Sunday", time: "09:00", zone: CHICAGO}
    b = {name: "B", day: "Sunday", time: "09:00", zone: CHICAGO}
    schedule = ServiceSchedule.new([])

    assert schedule.same_slot?(a, b)
  end

  def test_not_same_slot_when_zone_differs
    a = {name: "A", day: "Sunday", time: "09:00", zone: CHICAGO}
    b = {name: "B", day: "Sunday", time: "09:00", zone: NEW_YORK}
    schedule = ServiceSchedule.new([])

    refute schedule.same_slot?(a, b)
  end

  def test_not_same_slot_when_day_differs
    a = {name: "A", day: "Sunday", time: "09:00", zone: CHICAGO}
    b = {name: "B", day: "Wednesday", time: "09:00", zone: CHICAGO}
    schedule = ServiceSchedule.new([])

    refute schedule.same_slot?(a, b)
  end

  def test_not_same_slot_when_time_differs
    a = {name: "A", day: "Sunday", time: "09:00", zone: CHICAGO}
    b = {name: "B", day: "Sunday", time: "11:00", zone: CHICAGO}
    schedule = ServiceSchedule.new([])

    refute schedule.same_slot?(a, b)
  end

  def test_sorts_by_day_then_time
    schedule = ServiceSchedule.new([
      {name: "Wednesday Night", day: "Wednesday", time: "19:00", zone: CHICAGO},
      {name: "Sunday Evening", day: "Sunday", time: "18:00", zone: CHICAGO},
      {name: "Sunday Morning", day: "Sunday", time: "09:00", zone: CHICAGO},
    ])

    assert_equal ["Sunday Morning", "Sunday Evening", "Wednesday Night"], schedule.sorted_names
  end
end
