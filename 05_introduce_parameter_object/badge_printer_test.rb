require_relative "../test_helper"
require_relative "badge_printer"

class BadgePrinterTest < Minitest::Test
  def setup
    @printer = BadgePrinter.new
    @time = Time.new(2024, 11, 3, 10, 30)
  end

  def test_includes_full_name
    result = @printer.print_badge(build_data(first_name: "Maya", last_name: "Torres"))

    assert_includes result, "Maya Torres"
  end

  def test_includes_grade
    result = @printer.print_badge(build_data(grade: 4))

    assert_includes result, "Grade: 4"
  end

  def test_includes_check_in_time
    result = @printer.print_badge(build_data(check_in_time: Time.new(2024, 11, 3, 10, 30)))

    assert_includes result, "Checked in: 10:30 AM"
  end

  def test_includes_afternoon_time
    result = @printer.print_badge(build_data(check_in_time: Time.new(2024, 11, 3, 14, 15)))

    assert_includes result, "Checked in: 02:15 PM"
  end

  def test_includes_medical_note_when_present
    result = @printer.print_badge(build_data(medical_note: "Peanut allergy"))

    assert_includes result, "MEDICAL: Peanut allergy"
  end

  def test_omits_medical_line_when_nil
    result = @printer.print_badge(build_data(medical_note: nil))

    refute_includes result, "MEDICAL"
  end

  def test_lines_are_newline_separated
    result = @printer.print_badge(build_data)
    lines = result.split("\n")

    assert_equal 3, lines.length
  end

  def test_medical_note_adds_a_fourth_line
    result = @printer.print_badge(build_data(medical_note: "Epipen on file"))
    lines = result.split("\n")

    assert_equal 4, lines.length
  end

  def test_name_is_first_line
    result = @printer.print_badge(build_data(first_name: "Leo", last_name: "Kim"))
    first_line = result.split("\n").first

    assert_equal "Leo Kim", first_line
  end

  private

  def build_data(overrides = {})
    {
      first_name: "Sam",
      last_name: "Reed",
      grade: 3,
      check_in_time: @time,
      medical_note: nil,
    }.merge(overrides)
  end
end
