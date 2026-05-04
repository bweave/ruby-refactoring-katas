# Reference solution — do not share until after the learner completes the kata.

class NullFund
  def name = "General Fund"
  def tax_deductible = false
end

class Fund
  attr_reader :name, :tax_deductible

  def initialize(attrs)
    @name = attrs[:name]
    @tax_deductible = attrs[:tax_deductible]
  end
end

class DonationReceipt
  def initialize(donation)
    @donation = donation
    @fund = donation[:fund] ? Fund.new(donation[:fund]) : NullFund.new
  end

  def summary_line
    "#{formatted_amount} donated to #{@fund.name}"
  end

  def tax_line
    if @fund.tax_deductible
      "This contribution is tax-deductible."
    else
      "This contribution is not tax-deductible."
    end
  end

  def acknowledgment_note
    "Thank you for your gift to the #{@fund.name}."
  end

  private

  def formatted_amount
    "$#{"%.2f" % (@donation[:amount_cents] / 100.0)}"
  end
end
