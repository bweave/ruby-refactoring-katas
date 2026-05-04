# Kata 02 — Split Responsibility

## The Smell: One Class Doing Two Unrelated Jobs

`AttendanceReport#summary` does two separate things:

1. **Calculates** statistics from raw attendance data — counts, rates, totals
2. **Formats** those statistics into a human-readable report string

These are different reasons to change. If the business changes how attendance rate is
calculated, that's one change. If the report needs a new layout, that's a different change.
A class with two reasons to change violates the Single Responsibility Principle.

The tell: you can describe the class as "it calculates stuff **and** formats it."
The word "and" names the split.

## Your Goal

Split `AttendanceReport` into two focused classes:

- One class that computes the numbers — it knows nothing about strings or formatting
- One class that formats a report — it knows nothing about how numbers are calculated

Then `AttendanceReport` can be a thin coordinator that wires them together:

```ruby
def summary(group, attendances)
  stats = AttendanceStats.new(attendances)
  AttendanceSummaryFormatter.new.format(group, stats)
end
```

## Constraints

- Do not change `attendance_report_test.rb`
- Tests must stay green after every step — move one responsibility at a time
- The calculation class should have no string formatting
- The formatting class should do no arithmetic

## Check Your Work

Ask yourself:

- If the output format changes (add a line, change wording), which class changes?
- If the attendance rate formula changes, which class changes?

If the answer to both is "the same class," keep splitting.
