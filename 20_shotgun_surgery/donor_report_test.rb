require_relative "../test_helper"
require_relative "donor_report"

class DonorReportTest < Minitest::Test
  def setup
    @report = DonorReport.new
  end

  def test_bronze_badge_color
    assert_equal "#CD7F32", @report.badge_color("bronze")
  end

  def test_platinum_badge_color
    assert_equal "#E5E4E2", @report.badge_color("platinum")
  end

  def test_bronze_minimum_gift_is_zero
    assert_equal 0, @report.minimum_gift_cents("bronze")
  end

  def test_silver_minimum_gift
    assert_equal 50_000, @report.minimum_gift_cents("silver")
  end

  def test_gold_minimum_gift
    assert_equal 100_000, @report.minimum_gift_cents("gold")
  end

  def test_platinum_minimum_gift
    assert_equal 500_000, @report.minimum_gift_cents("platinum")
  end

  def test_bronze_tax_letter_template
    assert_equal "standard_acknowledgment", @report.tax_letter_template("bronze")
  end

  def test_gold_tax_letter_template
    assert_equal "gold_acknowledgment", @report.tax_letter_template("gold")
  end

  def test_bronze_has_no_perks
    assert_equal [], @report.perks("bronze")
  end

  def test_silver_perks
    assert_equal ["newsletter"], @report.perks("silver")
  end

  def test_platinum_perks
    assert_equal %w[newsletter event_invite personal_call], @report.perks("platinum")
  end
end
