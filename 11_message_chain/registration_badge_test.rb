require_relative "../test_helper"
require_relative "registration_badge"

class RegistrationBadgeTest < Minitest::Test
  def test_includes_full_name
    registration = build_registration(first_name: "Marco", last_name: "Reyes")

    assert_includes RegistrationBadge.new(registration).label, "Marco Reyes"
  end

  def test_includes_role
    registration = build_registration(role: "Greeter")

    assert_includes RegistrationBadge.new(registration).label, "Greeter"
  end

  def test_includes_campus_name
    registration = build_registration(campus: "Eastside")

    assert_includes RegistrationBadge.new(registration).label, "Eastside"
  end

  def test_format_is_name_role_campus
    registration =
      build_registration(first_name: "Dani", last_name: "Cruz", role: "Usher", campus: "Downtown")

    assert_equal "Dani Cruz — Usher — Downtown", RegistrationBadge.new(registration).label
  end

  def test_different_campus_produces_different_label
    registration = build_registration(campus: "Westside")

    assert_includes RegistrationBadge.new(registration).label, "Westside"
  end

  def test_different_role_produces_different_label
    registration = build_registration(role: "Worship Team")

    assert_includes RegistrationBadge.new(registration).label, "Worship Team"
  end

  private

  def build_registration(first_name: "Sam", last_name: "Park", role: "Volunteer", campus: "Main")
    campus_obj = Campus.new(name: campus)
    event = Event.new(title: "Sunday Service", campus: campus_obj)
    person = Person.new(first_name: first_name, last_name: last_name)
    Registration.new(person: person, event: event, role: role)
  end
end
