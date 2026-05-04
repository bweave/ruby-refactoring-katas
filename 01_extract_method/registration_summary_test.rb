require_relative "../test_helper"
require_relative "registration_summary"

class RegistrationSummaryTest < Minitest::Test
  def setup
    @summary = RegistrationSummary.new
  end

  def test_uses_first_name_when_no_preferred_name
    registration = build_registration(first_name: "Sarah", preferred_name: nil)

    assert_equal "Sarah Connor — Confirmed — Paid in full", @summary.summary_line(registration)
  end

  def test_uses_preferred_name_when_present
    registration = build_registration(preferred_name: "Bobby")

    assert_equal "Bobby Connor — Confirmed — Paid in full", @summary.summary_line(registration)
  end

  def test_ignores_blank_preferred_name
    registration = build_registration(preferred_name: "")

    assert_equal "Sarah Connor — Confirmed — Paid in full", @summary.summary_line(registration)
  end

  def test_confirmed_status
    registration = build_registration(status: "confirmed")

    assert_includes @summary.summary_line(registration), "Confirmed"
  end

  def test_pending_status
    registration = build_registration(status: "pending")

    assert_includes @summary.summary_line(registration), "Pending"
  end

  def test_waitlisted_status
    registration = build_registration(status: "waitlisted")

    assert_includes @summary.summary_line(registration), "Waitlisted"
  end

  def test_unknown_status_falls_back_gracefully
    registration = build_registration(status: "something_new")

    assert_includes @summary.summary_line(registration), "Unknown"
  end

  def test_paid_in_full_when_payments_cover_total
    registration = build_registration(total_due: 100, payments: [{ amount: 100 }])

    assert_includes @summary.summary_line(registration), "Paid in full"
  end

  def test_paid_in_full_when_overpaid
    registration = build_registration(total_due: 100, payments: [{ amount: 150 }])

    assert_includes @summary.summary_line(registration), "Paid in full"
  end

  def test_shows_remaining_balance
    registration = build_registration(total_due: 100, payments: [{ amount: 25 }])

    assert_includes @summary.summary_line(registration), "Owes $75.00"
  end

  def test_shows_balance_across_multiple_payments
    registration = build_registration(total_due: 100, payments: [{ amount: 40 }, { amount: 35 }])

    assert_includes @summary.summary_line(registration), "Owes $25.00"
  end

  def test_shows_balance_with_no_payments
    registration = build_registration(total_due: 50, payments: [])

    assert_includes @summary.summary_line(registration), "Owes $50.00"
  end

  private

  def build_registration(overrides = {})
    {
      first_name: "Sarah",
      preferred_name: nil,
      last_name: "Connor",
      status: "confirmed",
      total_due: 100,
      payments: [{ amount: 100 }],
    }.merge(overrides)
  end
end
