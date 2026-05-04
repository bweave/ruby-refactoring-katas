# Reference solution — do not share until after the learner completes the kata.

class Money
  include Comparable

  def initialize(cents)
    @cents = Integer(cents)
  end

  def +(other)
    Money.new(@cents + other.to_cents)
  end

  def -(other)
    Money.new(@cents - other.to_cents)
  end

  def <=>(other)
    @cents <=> other.to_cents
  end

  def fulfilled?
    @cents <= 0
  end

  def to_s
    "$#{"%.2f" % (@cents / 100.0)}"
  end

  def to_cents
    @cents
  end
end

ZERO = Money.new(0)

class PledgeTracker
  def initialize(pledges)
    @pledges = pledges
  end

  def summary
    remaining = total_pledged - total_paid
    status = remaining.fulfilled? ? "Fulfilled" : "In progress"
    "Pledged: #{total_pledged} | Paid: #{total_paid} | Remaining: #{remaining} | #{status}"
  end

  private

  def total_pledged
    @pledges.reduce(ZERO) { |sum, p| sum + Money.new(p[:amount_cents]) }
  end

  def total_paid
    @pledges.reduce(ZERO) { |sum, p| sum + Money.new(p[:paid_cents]) }
  end
end
