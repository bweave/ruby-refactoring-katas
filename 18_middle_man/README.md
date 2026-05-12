# Kata 18 — Middle Man

## The Smell: A Class That Just Passes Messages Along

`CheckInSummary` has four methods. Every one of them does the same thing:

```ruby
def total       = @stats.total
def by_location = @stats.by_location
def first_timers = @stats.first_timers
def returning   = @stats.returning
```

`CheckInSummary` contributes nothing. It delegates every call directly to
`CheckInStats` without adding behavior, translating inputs, or enforcing an
invariant. It exists purely to stand between a caller and the object that
actually does the work.

This is the **Middle Man** smell: a class so thin it is pure overhead. It
adds a layer of indirection without a reason. Every new method on `CheckInStats`
requires a matching stub on `CheckInSummary`. The two classes are coupled — they
just hide it behind forwarding calls.

Middle Man often appears when a refactoring that once made sense (hiding a
collaborator's interface) was never finished or has outlived its reason.

## Your Goal

Remove the middle man. Inline `CheckInStats`'s logic directly into
`CheckInSummary` and delete `CheckInStats`:

```ruby
class CheckInSummary
  def initialize(check_ins)
    @check_ins = check_ins
  end

  def total
    @check_ins.size
  end
  ...
end
```

When you're done, `CheckInStats` should not exist and `CheckInSummary` should
own all the behavior.

## Constraints

- Do not change `check_in_summary_test.rb`
- Tests must stay green throughout — move one method at a time
- `CheckInStats` must not exist in the file when you are done

## Check Your Work

Ask yourself: is there any class in the file that does nothing but hand
messages to another class? If the answer is no — the middle man is gone.

## Discussion Questions

1. When is a thin delegating class justified rather than a smell? What would have to be true about `CheckInSummary` for it to be worth keeping?
2. Middle Man often appears when a past refactoring was left half-finished. What refactoring might have created `CheckInSummary` in the first place?
3. How do you distinguish a useful facade from an unnecessary middle man?

## Going Further

After inlining, imagine a new requirement: check-ins from a "returning member"
path count double for reporting purposes. Where would that weighting logic go?
Notice how having one class makes the answer obvious, compared to figuring out
whether it belongs in `CheckInSummary` or `CheckInStats`.
