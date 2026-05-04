# Reference solution — do not share until after the learner completes the kata.

class MatchingGiftChecker
  def eligible?(person, gift)
    return false unless person[:active]
    return false unless gift[:amount_cents] >= 1000
    return false unless person[:employer_matching_enabled]
    return false unless gift[:amount_cents] <= person[:matching_limit_cents]

    true
  end
end
