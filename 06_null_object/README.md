# Kata 06 — Null Object Pattern

## The Smell: Nil Checks Repeated Across Every Method

`DonationReceipt` has five methods. Every one of them reaches into
`@donation[:fund]` and guards against `nil` before doing anything useful:

```ruby
def summary_line
  fund_name = @donation[:fund] ? @donation[:fund][:name] : "General Fund"
  ...
end

def giving_category
  @donation[:fund] ? @donation[:fund][:category] : "General"
end

def receipt_footer
  if @donation[:fund] && @donation[:fund][:tax_deductible]
    "Retain this receipt ... Fund: #{@donation[:fund][:name]}"
  elsif @donation[:fund]
    "Fund: #{@donation[:fund][:name]}"
  else
    "Fund: General Fund"
  end
end
```

Each check is small in isolation. Together, they form a pattern: every method
that touches `fund` must defend against its absence. As the class grows, every
new method either copies the pattern or forgets to — introducing a bug.

The root cause: `nil` is the wrong type. `nil` doesn't respond to `name`,
`tax_deductible`, or `category`. It isn't a fund. It's an absent value
masquerading as one.

Notice that you could extract a `fund_name` helper to reduce the duplication —
but you'd still need separate helpers for each attribute, and new methods would
still have to remember to call them. The nil-handling is scattered across the
class, not centralized.

The fix: replace the absent value with an object that *is* a fund — one that
responds to the same messages with sensible defaults. That's the **Null Object
pattern**.

## Your Goal

Introduce a `NullFund` class that responds to `name`, `tax_deductible`, and
`category` with safe defaults. Introduce a `Fund` class that wraps the real
fund hash. In `initialize`, assign `@fund` once — either a real `Fund` or a
`NullFund`. The five public methods should then call `@fund.name`,
`@fund.tax_deductible`, and `@fund.category` without any nil checks:

```ruby
def summary_line
  "#{formatted_amount} donated to #{@fund.name}"
end
```

## Constraints

- Do not change `donation_receipt_test.rb`
- Tests must stay green after every step
- No `if fund`, `fund &&`, or `nil?` checks in any of the five public methods
  when you're done

## Check Your Work

Ask yourself: if you add a sixth method that needs the fund's campaign code,
does it need to check for nil? If the answer is no — because `NullFund` returns
a safe default — the pattern is in place.
