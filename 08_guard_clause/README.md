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

## Discussion Questions

1. Does the order of guard clauses matter for correctness? Does it matter for readability? How would you prioritize them?
2. How does removing the nesting change the cognitive load of reading the method — specifically, what does the reader no longer have to track?
3. When might deeply nested conditionals be intentional and appropriate rather than a smell?

## Going Further

Add a fifth eligibility criterion — say, `employer[:match_program_active]`. Notice
it's a single new `return false unless ...` line at the top, rather than another
level of nesting. Then consider: could these conditions be extracted to named
predicates (kata 13 style)? When does that become worth doing?
