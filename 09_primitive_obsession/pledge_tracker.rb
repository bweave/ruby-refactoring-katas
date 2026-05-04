class PledgeTracker
  def initialize(pledges)
    @pledges = pledges
  end

  def summary
    total_pledged = @pledges.sum { |p| p[:amount_cents] }
    total_paid = @pledges.sum { |p| p[:paid_cents] }
    remaining = total_pledged - total_paid

    pledged_str = "$#{"%.2f" % (total_pledged / 100.0)}"
    paid_str = "$#{"%.2f" % (total_paid / 100.0)}"
    remaining_str = "$#{"%.2f" % (remaining / 100.0)}"

    status = remaining <= 0 ? "Fulfilled" : "In progress"
    "Pledged: #{pledged_str} | Paid: #{paid_str} | Remaining: #{remaining_str} | #{status}"
  end
end
