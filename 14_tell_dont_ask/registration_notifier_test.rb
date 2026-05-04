require_relative "../test_helper"
require_relative "registration_notifier"

class RegistrationNotifierTest < Minitest::Test
  def setup
    @notifier = RegistrationNotifier.new
  end

  def test_confirmed_and_paid_sends_confirmation
    registration =
      Registration.new(
        name: "Ana Lim",
        email: "ana@example.com",
        status: "confirmed",
        balance_cents: 0,
      )
    mailer = TestMailer.new

    @notifier.notify(registration, mailer)

    assert_equal [[:confirmation, "ana@example.com", "Ana Lim"]], mailer.sent
  end

  def test_confirmed_with_balance_sends_payment_reminder
    registration =
      Registration.new(
        name: "Ana Lim",
        email: "ana@example.com",
        status: "confirmed",
        balance_cents: 5000,
      )
    mailer = TestMailer.new

    @notifier.notify(registration, mailer)

    assert_equal [[:payment_reminder, "ana@example.com", "Ana Lim", 5000]], mailer.sent
  end

  def test_overpaid_sends_confirmation
    registration =
      Registration.new(
        name: "Ana Lim",
        email: "ana@example.com",
        status: "confirmed",
        balance_cents: -100,
      )
    mailer = TestMailer.new

    @notifier.notify(registration, mailer)

    assert_equal [[:confirmation, "ana@example.com", "Ana Lim"]], mailer.sent
  end

  def test_waitlisted_sends_waitlist_notice
    registration =
      Registration.new(
        name: "Ben Moss",
        email: "ben@example.com",
        status: "waitlisted",
        balance_cents: 0,
      )
    mailer = TestMailer.new

    @notifier.notify(registration, mailer)

    assert_equal [[:waitlist_notice, "ben@example.com", "Ben Moss"]], mailer.sent
  end

  def test_unknown_status_sends_nothing
    registration =
      Registration.new(
        name: "Cam Shaw",
        email: "cam@example.com",
        status: "cancelled",
        balance_cents: 0,
      )
    mailer = TestMailer.new

    @notifier.notify(registration, mailer)

    assert_empty mailer.sent
  end
end

class TestMailer
  attr_reader :sent

  def initialize
    @sent = []
  end

  def send_confirmation(email, name)
    @sent << [:confirmation, email, name]
  end

  def send_payment_reminder(email, name, balance_cents)
    @sent << [:payment_reminder, email, name, balance_cents]
  end

  def send_waitlist_notice(email, name)
    @sent << [:waitlist_notice, email, name]
  end
end
