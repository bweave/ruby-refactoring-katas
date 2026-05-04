# Kata 06 — Null Object Pattern

## The Smell: Nil Checks Scattered Across Multiple Methods

`DonationReceipt` has three methods — `summary_line`, `tax_line`, and
`acknowledgment_note` — and every one of them starts by fetching `@donation[:fund]`
and checking whether it's nil.

Each check is small in isolation. Together, they form a pattern: every method
that touches `fund` must defend against its absence. As the class grows, every
new method either copies the pattern or forgets to — introducing a bug.

The root cause: `nil` is the wrong type. `nil` doesn't respond to `name` or
`tax_deductible`. It isn't a fund. It's an absent value masquerading as one.

The fix: replace the absent value with an object that *is* a fund — one that
responds to the same messages with sensible defaults. That's the **Null Object
pattern**.

## Your Goal

Introduce a `NullFund` class that responds to `name` and `tax_deductible` with
safe defaults (`"General Fund"` and `false`). Introduce a `Fund` class that
wraps the real fund hash. In `initialize`, assign `@fund` once — either a real
`Fund` or a `NullFund`. The three public methods should then call `@fund.name`
and `@fund.tax_deductible` without any nil checks:

```ruby
def summary_line
  "#{formatted_amount} donated to #{@fund.name}"
end
```

## Constraints

- Do not change `donation_receipt_test.rb`
- Tests must stay green after every step
- No `if fund`, `fund &&`, or `nil?` checks in any of the three public methods
  when you're done

## Check Your Work

Ask yourself: if you add a fourth method that needs the fund's campaign code,
does it need to check for nil? If the answer is no — because `NullFund` returns
a safe default — the pattern is in place.
