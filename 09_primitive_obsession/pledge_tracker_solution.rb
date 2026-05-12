# Reference solution — do not share until after the learner completes the kata.

class Money
  attr_reader :amount_cents

  def initialize(cents)
    @amount_cents = Integer(cents)
  end

  def +(other)
    Money.new(amount_cents + other.amount_cents)
  end

  def -(other)
    Money.new(amount_cents - other.amount_cents)
  end

  def fulfilled?
    amount_cents <= 0
  end

  def to_s
    "$#{"%.2f" % (amount_cents / 100.0)}"
  end
end

class PledgeTracker
  def initialize(pledges)
    @pledges = pledges
  end

  def summary
    total_pledged = @pledges.sum(Money.new(0)) { |p| Money.new(p[:amount_cents]) }
    total_paid = @pledges.sum(Money.new(0)) { |p| Money.new(p[:paid_cents]) }
    remaining = total_pledged - total_paid
    status = remaining.fulfilled? ? "Fulfilled" : "In progress"

    "Pledged: #{total_pledged} | Paid: #{total_paid} | Remaining: #{remaining} | #{status}"
  end
end
