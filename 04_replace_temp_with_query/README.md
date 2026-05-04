# Kata 04 — Replace Temp with Query

## The Smell: Temporary Variables That Name Single Computations

`VolunteerSchedule#status_summary` computes four values — `confirmed_count`,
`needed_count`, `coverage_pct`, and `label` — then uses each exactly once in a
final interpolated string.

Every temporary variable is a deferred naming decision. When a temp's only job is
to hold one computed value, it's asking to become a method. The method gives the
computation a permanent name, makes it independently testable, and lets other
methods share it without duplication.

The tell: you can describe each temp as "compute X, then use X once." That pattern
has a name: **Replace Temp with Query**.

## Your Goal

Remove each local variable by extracting it to a private method named for what it
computes. When you're done, `status_summary` should read as a single interpolated
sentence with no local variables:

```ruby
def status_summary
  "#{role}: #{confirmed_count}/#{needed_count} (#{coverage_pct}%) — #{coverage_label}"
end
```

## Constraints

- Do not change `volunteer_schedule_test.rb`
- Tests must stay green after every extraction, not just at the end
- Each private method should do exactly one thing and return exactly one value
- `status_summary` itself should contain no local variables when you're done

## Check Your Work

Ask yourself: if the coverage threshold for "Partially staffed" changes from 60%
to 70%, which method changes? If the answer is `coverage_label` — and only
`coverage_label` — the extraction is complete.
