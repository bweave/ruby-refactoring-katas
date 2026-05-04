# Kata 15 — Encapsulate Collection

## The Smell: A Raw Collection Handed Directly to Callers

`ServiceTeam` exposes `@members` as a public reader:

```ruby
attr_reader :name, :members
```

This gives any caller unmediated access to the array. Code outside the class can
do anything to it:

```ruby
team.members << bad_data           # bypass add's validation
team.members.clear                  # wipe the team silently
team.members.sort_by! { ... }       # reorder in-place, surprise everyone
team.members.delete_if { ... }      # remove members without the team knowing
```

The team's invariants — "all members were added through `add`," "confirmed means
the team agrees it's confirmed" — disappear the moment the raw array is shared.
The class no longer controls its own data.

The tell: `attr_reader` (or `attr_accessor`) on a collection. Any external code
holding the array reference is outside the class's control.

## Your Goal

Remove `members` from `attr_reader`. Hide `@members` completely. Every operation
callers need — checking size, finding confirmed members, listing leaders, building
a roster — should go through a method the class deliberately exposes:

```ruby
attr_reader :name   # name stays public; members does not
```

## Constraints

- Do not change `service_team_test.rb`
- Tests must stay green throughout — remove the reader last, after confirming
  nothing in the tests calls `team.members` directly
- `@members` must not be accessible from outside the class when you're done

## Check Your Work

Ask yourself: is there any way for a caller to add a member without going through
`add`, or remove a member without a method that enforces the class's rules? If
the answer is no — the collection is encapsulated.
