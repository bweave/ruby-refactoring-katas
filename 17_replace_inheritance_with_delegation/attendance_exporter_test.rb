require_relative "../test_helper"
require_relative "attendance_exporter"

class AttendanceExporterTest < Minitest::Test
  def test_header_is_upcased
    exporter = AttendanceExporter.new([])

    assert_includes exporter.export, "WEEKLY ATTENDANCE"
  end

  def test_formats_week_row
    exporter = AttendanceExporter.new([{ week: "2025-04-06", total: 47, first_timers: 5 }])

    assert_includes exporter.export, "Week of 2025-04-06: 47 people (11% first-timers)"
  end

  def test_singular_person
    exporter = AttendanceExporter.new([{ week: "2025-04-06", total: 1, first_timers: 0 }])

    assert_includes exporter.export, "1 person"
  end

  def test_zero_first_timers
    exporter = AttendanceExporter.new([{ week: "2025-04-06", total: 50, first_timers: 0 }])

    assert_includes exporter.export, "0% first-timers"
  end

  def test_total_line_sums_all_records
    exporter =
      AttendanceExporter.new(
        [
          { week: "2025-03-30", total: 120, first_timers: 10 },
          { week: "2025-04-06", total: 80, first_timers: 5 },
        ],
      )

    assert_includes exporter.export, "Total: 200 people"
  end

  def test_divider_appears_before_total
    exporter = AttendanceExporter.new([{ week: "2025-04-06", total: 50, first_timers: 3 }])

    assert_includes exporter.export, "#{"-" * 40}\nTotal:"
  end

  def test_empty_records_shows_zero_total
    exporter = AttendanceExporter.new([])

    assert_includes exporter.export, "Total: 0 people"
  end
end
