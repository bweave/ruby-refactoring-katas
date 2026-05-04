require_relative "../test_helper"
require_relative "team_member"

class TeamMemberTest < Minitest::Test
  def test_mailing_label_includes_name
    member = TeamMember.new(build_attrs(name: "Jordan Lee"))

    assert_includes member.mailing_label, "Jordan Lee"
  end

  def test_mailing_label_includes_street
    member = TeamMember.new(build_attrs(street: "123 Main St"))

    assert_includes member.mailing_label, "123 Main St"
  end

  def test_mailing_label_includes_city_state_zip
    member = TeamMember.new(build_attrs(city: "Fresno", state: "CA", zip: "93710"))

    assert_includes member.mailing_label, "Fresno, CA 93710"
  end

  def test_mailing_label_is_three_lines
    member = TeamMember.new(build_attrs)
    lines = member.mailing_label.split("\n")

    assert_equal 3, lines.length
  end

  def test_mailing_label_name_is_first_line
    member = TeamMember.new(build_attrs(name: "Riley Park"))
    first_line = member.mailing_label.split("\n").first

    assert_equal "Riley Park", first_line
  end

  def test_address_summary_is_single_line
    member =
      TeamMember.new(build_attrs(street: "45 Oak Ave", city: "Visalia", state: "CA", zip: "93291"))

    assert_equal "45 Oak Ave, Visalia, CA 93291", member.address_summary
  end

  def test_same_city_when_city_and_state_match
    member1 = TeamMember.new(build_attrs(city: "Fresno", state: "CA"))
    member2 = TeamMember.new(build_attrs(city: "Fresno", state: "CA"))

    assert member1.same_city?(member2)
  end

  def test_not_same_city_when_city_differs
    member1 = TeamMember.new(build_attrs(city: "Fresno", state: "CA"))
    member2 = TeamMember.new(build_attrs(city: "Clovis", state: "CA"))

    refute member1.same_city?(member2)
  end

  def test_not_same_city_when_state_differs
    member1 = TeamMember.new(build_attrs(city: "Springfield", state: "IL"))
    member2 = TeamMember.new(build_attrs(city: "Springfield", state: "MO"))

    refute member1.same_city?(member2)
  end

  private

  def build_attrs(overrides = {})
    {
      name: "Alex Morgan",
      email: "alex@example.com",
      street: "100 Church St",
      city: "Fresno",
      state: "CA",
      zip: "93710",
    }.merge(overrides)
  end
end
