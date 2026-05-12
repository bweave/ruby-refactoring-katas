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

## Discussion Questions

1. After the split, could either new class be split again? How would you know when to stop?
2. The formatter takes a `stats` object as a collaborator. How does that keep it from leaking calculation knowledge?
3. What if you needed a second formatter (e.g., CSV output)? Which classes would change, and which wouldn't?

## Going Further

Add a `percentage_format` method to the formatter that controls how rates are
displayed (e.g., `"75%"` vs. `"0.75"`). Notice that only the formatter changes —
the stats class is completely untouched. Then consider: what if you needed the
stats class to also support a `median_attendance` method? Where does that go?
