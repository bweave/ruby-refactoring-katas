require_relative "../test_helper"
require_relative "pledge_tracker"

class PledgeTrackerTest < Minitest::Test
  def test_shows_total_pledged_amount
    tracker = PledgeTracker.new([{ amount_cents: 10_000, paid_cents: 10_000 }])

    assert_includes tracker.summary, "Pledged: $100.00"
  end

  def test_shows_total_paid_amount
    tracker = PledgeTracker.new([{ amount_cents: 10_000, paid_cents: 4_000 }])

    assert_includes tracker.summary, "Paid: $40.00"
  end

  def test_shows_remaining_balance
    tracker = PledgeTracker.new([{ amount_cents: 10_000, paid_cents: 6_000 }])

    assert_includes tracker.summary, "Remaining: $40.00"
  end

  def test_fulfilled_when_paid_equals_pledged
    tracker = PledgeTracker.new([{ amount_cents: 10_000, paid_cents: 10_000 }])

    assert_includes tracker.summary, "Fulfilled"
  end

  def test_fulfilled_when_overpaid
    tracker = PledgeTracker.new([{ amount_cents: 10_000, paid_cents: 12_000 }])

    assert_includes tracker.summary, "Fulfilled"
  end

  def test_in_progress_when_partially_paid
    tracker = PledgeTracker.new([{ amount_cents: 10_000, paid_cents: 5_000 }])

    assert_includes tracker.summary, "In progress"
  end

  def test_sums_multiple_pledges
    pledges = [
      { amount_cents: 5_000, paid_cents: 5_000 },
      { amount_cents: 5_000, paid_cents: 2_500 },
    ]

    tracker = PledgeTracker.new(pledges)

    assert_includes tracker.summary, "Pledged: $100.00"
    assert_includes tracker.summary, "Paid: $75.00"
  end

  def test_formats_cents_correctly
    tracker = PledgeTracker.new([{ amount_cents: 1_099, paid_cents: 0 }])

    assert_includes tracker.summary, "$10.99"
  end

  def test_empty_pledges_shows_zero_totals
    tracker = PledgeTracker.new([])

    assert_includes tracker.summary, "Pledged: $0.00"
    assert_includes tracker.summary, "Paid: $0.00"
    assert_includes tracker.summary, "Fulfilled"
  end
end
