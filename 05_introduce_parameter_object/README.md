# Kata 05 — Introduce Parameter Object

## The Smell: Data Clump Passed as an Anonymous Hash

`BadgePrinter#print_badge` receives a hash and immediately extracts five keys
into five separate local variables. That upfront unpacking is a sign that the
five fields belong together — they always travel as a group, they describe the
same thing, and they need to be unwrapped every time they're used.

When a cluster of data items always appears together — always passed together,
always unpacked together — that cluster is a **Data Clump**. Here the clump is
hiding inside a hash: the five fields always arrive as a unit and are always
used together. The hash is an anonymous data bag with no name, no behavior, and
no obvious home for logic that works on its contents (like formatting a full name
or a check-in time). A named object fixes all three.

The tell: if you wrote `first_name = data[:first_name]` five times in five
different methods, you'd see the duplication instantly. Doing it once at the
top of one method hides the same problem.

Contrast this with Kata 10, where the clump lives inside a class as separate
fields. The fix is the same — extract the group into its own object — but the
starting point differs.

## Your Goal

Introduce a `CheckIn` value object that encapsulates the five fields. Use a
`Struct` with `keyword_init: true`. Move any logic that belongs on the data
into the struct — full name formatting, time formatting — so `print_badge` just
asks the object for what it needs:

```ruby
def print_badge(data)
  check_in = CheckIn.new(**data)
  # use check_in.full_name, check_in.formatted_time, etc.
end
```

## Constraints

- Do not change `badge_printer_test.rb`
- The method signature stays `def print_badge(data)` — the caller still passes a hash
- Tests must stay green after every step
- `BadgePrinter#print_badge` should contain no local variable extractions when done

## Check Your Work

Ask yourself: if you needed to add a `room_number` field to every badge, where
does that change live? If the answer is only `CheckIn` — and not `BadgePrinter`
— the refactoring is complete.

## Discussion Questions

1. After introducing `CheckIn`, what is `BadgePrinter`'s responsibility? Has it shrunk?
2. Should `CheckIn` validate its fields — for example, require that `first_name` is not blank? Or is validation a different concern?
3. `CheckIn` is a `Struct`. If you needed `CheckIn` to inherit from another class, what would you change, and what would stay the same?

## Going Further

Add a second printer — say, a `WristbandPrinter` — that uses `CheckIn` to format
a shorter label. Notice that neither printer duplicates the field-unpacking logic;
they both just ask `CheckIn` for what they need. This is the payoff of the
parameter object: the clump is resolved once, and all consumers benefit.
