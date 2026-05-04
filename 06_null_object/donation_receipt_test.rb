require_relative "../test_helper"
require_relative "donation_receipt"

class DonationReceiptTest < Minitest::Test
  def test_summary_line_with_designated_fund
    receipt =
      DonationReceipt.new(build_donation(fund: { name: "Youth Ministry", tax_deductible: true }))

    assert_equal "$50.00 donated to Youth Ministry", receipt.summary_line
  end

  def test_summary_line_without_fund_uses_general_fund
    receipt = DonationReceipt.new(build_donation(fund: nil))

    assert_equal "$50.00 donated to General Fund", receipt.summary_line
  end

  def test_summary_line_formats_cents_as_dollars
    receipt = DonationReceipt.new(build_donation(amount_cents: 2575, fund: nil))

    assert_equal "$25.75 donated to General Fund", receipt.summary_line
  end

  def test_tax_line_when_fund_is_tax_deductible
    receipt = DonationReceipt.new(build_donation(fund: { name: "Missions", tax_deductible: true }))

    assert_equal "This contribution is tax-deductible.", receipt.tax_line
  end

  def test_tax_line_when_fund_is_not_tax_deductible
    receipt =
      DonationReceipt.new(build_donation(fund: { name: "Building Fund", tax_deductible: false }))

    assert_equal "This contribution is not tax-deductible.", receipt.tax_line
  end

  def test_tax_line_when_no_fund
    receipt = DonationReceipt.new(build_donation(fund: nil))

    assert_equal "This contribution is not tax-deductible.", receipt.tax_line
  end

  def test_acknowledgment_with_designated_fund
    receipt =
      DonationReceipt.new(build_donation(fund: { name: "Youth Ministry", tax_deductible: true }))

    assert_equal "Thank you for your gift to the Youth Ministry.", receipt.acknowledgment_note
  end

  def test_acknowledgment_without_fund_uses_general_fund
    receipt = DonationReceipt.new(build_donation(fund: nil))

    assert_equal "Thank you for your gift to the General Fund.", receipt.acknowledgment_note
  end

  private

  def build_donation(overrides = {})
    { amount_cents: 5000, fund: nil }.merge(overrides)
  end
end
