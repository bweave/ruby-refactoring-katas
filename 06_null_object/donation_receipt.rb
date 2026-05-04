class DonationReceipt
  def initialize(donation)
    @donation = donation
  end

  def summary_line
    amount = formatted_amount
    fund = @donation[:fund]
    fund ? "#{amount} donated to #{fund[:name]}" : "#{amount} donated to General Fund"
  end

  def tax_line
    fund = @donation[:fund]
    if fund && fund[:tax_deductible]
      "This contribution is tax-deductible."
    else
      "This contribution is not tax-deductible."
    end
  end

  def acknowledgment_note
    fund = @donation[:fund]
    if fund
      "Thank you for your gift to the #{fund[:name]}."
    else
      "Thank you for your gift to the General Fund."
    end
  end

  private

  def formatted_amount
    "$#{"%.2f" % (@donation[:amount_cents] / 100.0)}"
  end
end
