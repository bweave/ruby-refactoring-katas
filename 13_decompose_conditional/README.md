# Kata 13 — Decompose Conditional

## The Smell: A Condition That Requires a Comment to Understand

`TeamLeaderEligibility#eligible?` returns the result of five conditions joined
by `&&`. Each condition is a data lookup with a comparison:

```ruby
volunteer[:years_serving] >= 2 &&
  volunteer[:background_check] == "cleared" &&
  !volunteer[:on_leave] &&
  volunteer[:training_complete] &&
  volunteer[:attendance_pct] >= 75
```

Reading this requires translating each expression before you can understand what
it means. You have to know that `>= 2` means "meets tenure," that `!on_leave`
means "available," that `attendance_pct >= 75` means "regular attender." The
code makes you do the translation every time.

`ineligible_reason` has the same problem in its `elsif` chain — each branch
re-states the same raw expressions.

The tell: if you'd reach for a comment to explain what a condition means, the
condition wants to be a method with that name.

## Your Goal

Extract each condition to a private predicate method named for its meaning, not
its mechanics. `eligible?` should then read as a sentence of intent:

```ruby
def eligible?(volunteer)
  meets_tenure?(volunteer) &&
    background_cleared?(volunteer) &&
    available?(volunteer) &&
    training_complete?(volunteer) &&
    regular_attender?(volunteer)
end
```

The same predicates eliminate the duplication in `ineligible_reason`.

## Constraints

- Do not change `team_leader_eligibility_test.rb`
- Tests must stay green after every extraction
- No raw hash lookups (`volunteer[:key]`) in the public methods when you're done
  — those live only in the private predicates

## Check Your Work

Ask yourself: can you read `eligible?` out loud and have it be a description of
what makes someone eligible — with no numbers, no string comparisons, no `!`?
If yes, the decomposition is complete.
