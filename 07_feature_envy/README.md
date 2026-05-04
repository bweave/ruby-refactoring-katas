# Kata 07 — Feature Envy

## The Smell: A Method More Interested in Another Object Than Its Own

`GroupReport#membership_summary` takes a `group` and immediately digs into
three of its attributes: `member_count`, `inactive_count`, and `name`. It
subtracts, divides, rounds, and formats — all using `group`'s data. `GroupReport`
contributes nothing but arithmetic on someone else's numbers.

That's Feature Envy: a method so interested in another object's data that it
belongs over there, not here.

The tell: count how many times the method touches `group` vs. how many times it
touches `self`. If it's all `group`, the method wants to move.

## Your Goal

Move the computation to `Group`. Convert `Group` from a `Struct` to a full class
that owns `active_count`, the percentage, and the formatted summary string.
`GroupReport#membership_summary` should become a one-liner that delegates:

```ruby
def membership_summary(group)
  group.membership_summary
end
```

## Constraints

- Do not change `group_report_test.rb`
- Tests must stay green after every step
- The logic for computing active count and percentage must live on `Group`,
  not on `GroupReport`
- `GroupReport#membership_summary` should contain no arithmetic when you're done

## Check Your Work

Ask yourself: if the formula for active percentage changes, which class changes?
If the answer is `Group` — and `GroupReport` never needs to open — the method
is in the right place.
