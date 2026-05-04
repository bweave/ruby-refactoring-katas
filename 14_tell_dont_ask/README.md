# Kata 14 — Tell Don't Ask

## The Smell: Asking for State, Then Acting Elsewhere

`RegistrationNotifier#notify` interrogates a `Registration` object — asking for
its `status`, its `balance_cents`, its `email`, its `name` — and then makes all
the decisions itself:

```ruby
if registration.status == "confirmed"
  if registration.balance_cents <= 0
    mailer.send_confirmation(registration.email, registration.name)
  ...
```

The `Registration` object is being treated as a data bag. It hands over its
state and then stands aside while someone else decides what to do with it.

That decision logic belongs with the data. `Registration` knows its own status
and balance. It knows when it's confirmed, when it's been paid, when it's
waitlisted. Making `RegistrationNotifier` carry all that knowledge means every
new context that needs to act on a registration will duplicate the same logic —
or get it wrong.

The principle: **Tell objects what you need done; don't ask for their state and
decide yourself.**

## Your Goal

Move the notification logic into `Registration`. Convert `Registration` from a
`Struct` into a full class with a `notify(mailer)` method that makes its own
decisions. `RegistrationNotifier` should collapse to a single delegation:

```ruby
def notify(registration, mailer)
  registration.notify(mailer)
end
```

## Constraints

- Do not change `registration_notifier_test.rb`
- Tests must stay green after every step
- `RegistrationNotifier#notify` must contain no `if`, no `status ==`, no
  `balance_cents` when you're done

## Check Your Work

Ask yourself: if a new status `"cancelled"` needs to trigger a different email,
which class changes? If the answer is `Registration` — and `RegistrationNotifier`
never opens — the decision lives in the right place.
