# Kata 12 — Collection Pipeline

## The Smell: Loops That Do the Work Themselves

Every method in `VolunteerRoster` follows the same pattern: declare an
accumulator, loop with `each`, manually update the accumulator inside a
conditional, return it at the end.

```ruby
names = []
@volunteers.each do |v|
  if v[:status] == "confirmed"
    names << "#{v[:first_name]} #{v[:last_name]}"
  end
end
names
```

This works, but it forces you to read the *how* before you can understand the
*what*. The collection intent — "give me the names of confirmed volunteers" —
is buried inside imperative mechanics.

Ruby's Enumerable methods (`select`, `map`, `any?`, `sum`, `group_by`) are the
idiomatic answer. Each one names the operation and removes the accumulator
entirely. The code reads like a description of what you want, not instructions
for how to get it.

## Your Goal

Replace each imperative loop with the appropriate Enumerable method. Pick the
right one for the job:

- Filter a collection → `select`
- Transform each element → `map`
- Check if at least one matches → `any?`
- Add values up → `sum`
- Group into buckets and count → `group_by` + `transform_values`

## Constraints

- Do not change `volunteer_roster_test.rb`
- Tests must stay green after every replacement — convert one method at a time
- No `each` loops and no manual accumulator variables when you're done

## Check Your Work

Ask yourself: can you read each method body out loud and have it describe what
it does, not how? If `confirmed_names` reads like "select confirmed, then map to
full name" — with no mention of arrays or loops — the pipeline is in place.

## Discussion Questions

1. When is an imperative `each` loop preferable to a pipeline? Are there cases where the loop version is clearer?
2. `select { }.map { }` vs. `filter_map { }` — when would you choose each?
3. A pipeline chains transformations. When does chaining too many steps in one expression hurt readability?

## Going Further

Add a `by_team` method that returns a hash of `{ team_name => [volunteer, ...] }`
for confirmed volunteers, grouped by team. The `group_by` method handles this
in one pipeline step. Then add `team_counts` that maps each team name to its
count using `transform_values`.
