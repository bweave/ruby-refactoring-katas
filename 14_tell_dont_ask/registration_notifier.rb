Registration = Struct.new(:name, :email, :status, :balance_cents, keyword_init: true)

class RegistrationNotifier
  def notify(registration, mailer)
    if registration.status == "confirmed"
      if registration.balance_cents <= 0
        mailer.send_confirmation(registration.email, registration.name)
      else
        mailer.send_payment_reminder(
          registration.email,
          registration.name,
          registration.balance_cents,
        )
      end
    elsif registration.status == "waitlisted"
      mailer.send_waitlist_notice(registration.email, registration.name)
    end
  end
end
