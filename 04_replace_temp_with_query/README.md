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

## Discussion Questions

1. A temp variable computed once vs. a query method called on every access — what's the tradeoff when the computation is expensive?
2. Now that `confirmed_count` is a method, could you test it directly? Would that test add value, or is the behavior already covered through `status_summary`?
3. `coverage_label` encodes two thresholds. How would you name the constants that represent them to make the rule self-documenting?

## Going Further

Add a `fully_staffed?` predicate that returns true when `confirmed_count >= needed_count`.
Notice how it reads naturally using the query methods you've already extracted.
Then use it inside `coverage_label` to eliminate the `100%` branch.
