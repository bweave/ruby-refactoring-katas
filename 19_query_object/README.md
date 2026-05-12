# Kata 19 — Query Object

## The Smell: Repeated Filter Logic in Every Method

`VolunteerPool` has five query methods. Each one assembles a filter from
scratch using raw `select` and `&&` conditions:

```ruby
def available_for(team)
  @volunteers.select { |v| v[:available] && v[:team] == team }
end

def ready_for(team)
  @volunteers.select { |v| v[:available] && v[:qualified] && v[:team] == team }
end
```

The individual conditions — "on this team", "is available", "is qualified" —
are meaningful business rules, but they're expressed inline as hash key checks.
`ready_for` re-implements the "on this team" check that `available_for` already
wrote. Adding a new condition (`:background_cleared`, `:minimum_shifts_served`)
means editing every affected method.

The smell: query knowledge is scattered. Each method owns a copy of the same
atomic filter fragments, recombined slightly differently each time.

## Your Goal

Extract a `VolunteerQuery` class that encapsulates each filter as a named method
and returns a new query rather than a raw array, enabling composition:

```ruby
def ready_for(team)
  query.team(team).available.qualified.to_a
end
```

Each criterion lives in one place. Combining them reads like the business rule.
Adding `:background_cleared` means adding one method to `VolunteerQuery` — the
roster methods just chain it in where needed.

## Constraints

- Do not change `volunteer_roster_test.rb`
- Tests must stay green throughout
- No `v[:available]`, `v[:qualified]`, or `v[:first_timer]` checks should
  remain in `VolunteerPool` when you are done — that knowledge belongs on
  `VolunteerQuery`

## Check Your Work

Ask yourself: if a new filter `:background_cleared` is added, how many places
change? If the answer is "add one method to `VolunteerQuery`, then chain it
where needed" — the query knowledge is centralized.

## Discussion Questions

1. What does `VolunteerQuery` give you that a module with static helper methods wouldn't? What's the key difference?
2. `VolunteerQuery` chains methods and returns `self`. How does that compare to ActiveRecord's query interface?
3. What's the difference between a Query Object and a scope method on a model? When would you use each?

## Going Further

Add a `background_cleared` filter method to `VolunteerQuery`. Then use it in
`VolunteerPool#ready_for` without changing `available_for` or any other method.
Then add a `limit(n)` method — notice how it composes cleanly with any filter
chain.
