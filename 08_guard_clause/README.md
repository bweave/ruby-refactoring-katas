# Kata 08 — Guard Clause

## The Smell: The Arrow Anti-Pattern

`MatchingGiftChecker#eligible?` uses four levels of nested `if` to check four
conditions. Each successful check pushes the happy path one level deeper. The
actual result — `true` — is buried at the innermost indent. Every `false` is
tucked into an `else` clause.

This shape is called the **arrow anti-pattern**: the code forms a rightward
arrowhead as conditions nest. It's hard to read because the reader must track
the indent level to know which condition a given `false` returns from.

The fix: check each failure condition up front and return early. These early
returns are **guard clauses** — they guard the happy path by eliminating
non-qualifying cases before the main logic runs.

## Your Goal

Replace the nested `if` chain with four guard clauses. Each guard should
handle one condition and bail out with `return false unless …`. The happy
path — `true` — becomes an unconditional final line:

```ruby
def eligible?(person, gift)
  return false unless person[:active]
  return false unless gift[:amount_cents] >= 1000
  # ...
  true
end
```

## Constraints

- Do not change `matching_gift_checker_test.rb`
- Tests must stay green throughout — refactor one level of nesting at a time
- The final method must have no `if/else` nesting; only `return` statements and
  a final `true`

## Check Your Work

Ask yourself: can you read the method top-to-bottom and know immediately which
condition causes each `false`? If yes — and there's no indentation past the
method body — the guard clauses are in place.
