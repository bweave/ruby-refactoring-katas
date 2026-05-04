# Reference solution — do not share until after the learner completes the kata.

class RegistrationSummary
  def summary_line(registration)
    "#{display_name(registration)} — #{status_label(registration)} — #{balance_label(registration)}"
  end

  private

  def display_name(registration)
    preferred = registration[:preferred_name]
    first = preferred && !preferred.empty? ? preferred : registration[:first_name]
    "#{first} #{registration[:last_name]}"
  end

  def status_label(registration)
    case registration[:status]
    when "confirmed"
      "Confirmed"
    when "pending"
      "Pending"
    when "waitlisted"
      "Waitlisted"
    else
      "Unknown"
    end
  end

  def balance_label(registration)
    total_paid = registration[:payments].sum { |payment| payment[:amount] }
    balance = registration[:total_due] - total_paid
    balance <= 0 ? "Paid in full" : "Owes $#{"%.2f" % balance}"
  end
end
