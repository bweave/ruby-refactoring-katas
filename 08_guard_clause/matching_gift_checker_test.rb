require_relative "../test_helper"
require_relative "matching_gift_checker"

class MatchingGiftCheckerTest < Minitest::Test
  def setup
    @checker = MatchingGiftChecker.new
  end

  def test_eligible_when_all_conditions_met
    assert @checker.eligible?(eligible_person, qualifying_gift)
  end

  def test_ineligible_when_person_is_inactive
    person = eligible_person.merge(active: false)

    refute @checker.eligible?(person, qualifying_gift)
  end

  def test_ineligible_when_gift_below_minimum
    gift = qualifying_gift.merge(amount_cents: 999)

    refute @checker.eligible?(eligible_person, gift)
  end

  def test_eligible_at_exactly_minimum_amount
    gift = qualifying_gift.merge(amount_cents: 1000)

    assert @checker.eligible?(eligible_person, gift)
  end

  def test_ineligible_when_employer_matching_not_enabled
    person = eligible_person.merge(employer_matching_enabled: false)

    refute @checker.eligible?(person, qualifying_gift)
  end

  def test_ineligible_when_gift_exceeds_matching_limit
    gift = qualifying_gift.merge(amount_cents: 60_000)

    refute @checker.eligible?(eligible_person, gift)
  end

  def test_eligible_at_exactly_matching_limit
    gift = qualifying_gift.merge(amount_cents: 50_000)

    assert @checker.eligible?(eligible_person, gift)
  end

  def test_ineligible_when_both_inactive_and_below_minimum
    person = eligible_person.merge(active: false)
    gift = qualifying_gift.merge(amount_cents: 500)

    refute @checker.eligible?(person, gift)
  end

  private

  def eligible_person
    { active: true, employer_matching_enabled: true, matching_limit_cents: 50_000 }
  end

  def qualifying_gift
    { amount_cents: 10_000 }
  end
end
