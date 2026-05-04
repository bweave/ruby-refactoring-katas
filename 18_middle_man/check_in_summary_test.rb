require_relative "../test_helper"
require_relative "check_in_summary"

class CheckInSummaryTest < Minitest::Test
  RECORDS = [
    { location: "Main", first_time: false },
    { location: "Main", first_time: true },
    { location: "Kids", first_time: false },
    { location: "Kids", first_time: false },
    { location: "Overflow", first_time: true },
  ].freeze

  def test_total
    assert_equal 5, CheckInSummary.new(RECORDS).total
  end

  def test_by_location
    expected = { "Main" => 2, "Kids" => 2, "Overflow" => 1 }

    assert_equal expected, CheckInSummary.new(RECORDS).by_location
  end

  def test_first_timers
    assert_equal 2, CheckInSummary.new(RECORDS).first_timers
  end

  def test_returning
    assert_equal 3, CheckInSummary.new(RECORDS).returning
  end

  def test_empty_records
    summary = CheckInSummary.new([])

    assert_equal 0, summary.total
    assert_equal({}, summary.by_location)
    assert_equal 0, summary.first_timers
    assert_equal 0, summary.returning
  end
end
