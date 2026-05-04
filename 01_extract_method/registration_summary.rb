class RegistrationSummary
  def summary_line(registration)
    # Determine display name
    if registration[:preferred_name] && !registration[:preferred_name].empty?
      name = "#{registration[:preferred_name]} #{registration[:last_name]}"
    else
      name = "#{registration[:first_name]} #{registration[:last_name]}"
    end

    # Translate status to a label
    if registration[:status] == "confirmed"
      status = "Confirmed"
    elsif registration[:status] == "pending"
      status = "Pending"
    elsif registration[:status] == "waitlisted"
      status = "Waitlisted"
    else
      status = "Unknown"
    end

    # Calculate balance and format it
    total_paid = registration[:payments].sum { |payment| payment[:amount] }
    balance = registration[:total_due] - total_paid
    if balance <= 0
      balance_label = "Paid in full"
    else
      balance_label = "Owes $#{"%.2f" % balance}"
    end

    "#{name} — #{status} — #{balance_label}"
  end
end
