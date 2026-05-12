# Reference solution — do not share until after the learner completes the kata.

class NullFund
  def name = "General Fund"
  def tax_deductible = false
  def category = "General"
end

class Fund
  attr_reader :name, :tax_deductible, :category

  def initialize(attrs)
    @name = attrs[:name]
    @tax_deductible = attrs[:tax_deductible]
    @category = attrs[:category] || "General"
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

  def giving_category
    @fund.category
  end

  def receipt_footer
    if @fund.tax_deductible
      "Retain this receipt for your tax records. Fund: #{@fund.name}"
    else
      "Fund: #{@fund.name}"
    end
  end

  private

  def formatted_amount
    "$#{"%.2f" % (@donation[:amount_cents] / 100.0)}"
  end
end
