class DonationReceipt
  def initialize(donation)
    @donation = donation
  end

  def summary_line
    fund_name = @donation[:fund] ? @donation[:fund][:name] : "General Fund"
    "#{formatted_amount} donated to #{fund_name}"
  end

  def tax_line
    if @donation[:fund] && @donation[:fund][:tax_deductible]
      "This contribution is tax-deductible."
    else
      "This contribution is not tax-deductible."
    end
  end

  def acknowledgment_note
    fund_name = @donation[:fund] ? @donation[:fund][:name] : "General Fund"
    "Thank you for your gift to the #{fund_name}."
  end

  def giving_category
    @donation[:fund] ? @donation[:fund][:category] : "General"
  end

  def receipt_footer
    if @donation[:fund] && @donation[:fund][:tax_deductible]
      "Retain this receipt for your tax records. Fund: #{@donation[:fund][:name]}"
    elsif @donation[:fund]
      "Fund: #{@donation[:fund][:name]}"
    else
      "Fund: General Fund"
    end
  end

  private

  def formatted_amount
    "$#{"%.2f" % (@donation[:amount_cents] / 100.0)}"
  end
end
