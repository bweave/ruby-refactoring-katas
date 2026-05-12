# Kata 09 — Primitive Obsession

## The Smell: Money as a Raw Integer

`PledgeTracker#summary` works entirely with integer cent values. Every time it
needs a dollar string, it repeats the same formatting expression:
`"$#{"%.2f" % (cents / 100.0)}"`. The "fulfilled" check is an inline comparison
against zero. The arithmetic — sum, subtract — is done directly on integers.

That duplication is a symptom. The root cause is that the domain concept "money"
has been collapsed into a plain integer. Integers don't know they represent
dollars and cents. They can't format themselves, and they can't tell you whether
a balance is fulfilled.

The smell has a name: **Primitive Obsession** — using a built-in type where a
domain type belongs.

## Your Goal

Introduce a `Money` value object that wraps a cent integer and owns:

- Dollar-formatted string output (`to_s`)
- Addition and subtraction that return new `Money` objects
- A predicate (`fulfilled?`) for the "paid in full" check

When you're done, `summary` should read like arithmetic on money objects, not
raw integers:

```ruby
remaining = total_pledged - total_paid
status = remaining.fulfilled? ? "Fulfilled" : "In progress"
"Pledged: #{total_pledged} | Paid: #{total_paid} | ..."
```

## Constraints

- Do not change `pledge_tracker_test.rb`
- Tests must stay green after every step
- No `/ 100.0`, `"%.2f"`, or `<= 0` comparisons should remain in `PledgeTracker`
  when you're done — that logic belongs on `Money`

## Check Your Work

Ask yourself: if the currency format changes from `$10.00` to `10.00 USD`, which
class changes? If the answer is only `Money` — and `PledgeTracker` never opens —
the value object is doing its job.

## Discussion Questions

1. `Money` now owns formatting and arithmetic. What other behaviors might eventually belong on `Money` — and what behaviors should *not* live there?
2. How does wrapping cents in a `Money` object protect against bugs like accidentally mixing a cent-valued integer with a dollar-valued float?
3. What is the minimum interface `Money` needs to make `PledgeTracker` work cleanly?

## Going Further

Add a `zero?` method to `Money` that returns `true` when the amount is zero. Notice
how natural it reads — `remaining.zero?` vs. `remaining.amount_cents == 0`. Then
consider: should `fulfilled?` delegate to `zero?`, or are "fulfilled" and "zero"
genuinely different concepts in this domain?
