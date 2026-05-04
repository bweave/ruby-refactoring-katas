# Reference solution — do not share until after the learner completes the kata.

class Registration
  attr_reader :name, :email, :status, :balance_cents

  def initialize(name:, email:, status:, balance_cents:)
    @name = name
    @email = email
    @status = status
    @balance_cents = balance_cents
  end

  def notify(mailer)
    if status == "confirmed"
      if balance_cents <= 0
        mailer.send_confirmation(email, name)
      else
        mailer.send_payment_reminder(email, name, balance_cents)
      end
    elsif status == "waitlisted"
      mailer.send_waitlist_notice(email, name)
    end
  end
end

class RegistrationNotifier
  def notify(registration, mailer)
    registration.notify(mailer)
  end
end
