# Ruby Design Katas

Katas for building design intuition. Each one gives you messy but working code
and a passing test suite. Your job: refactor until the code is clean while keeping
every test green.

## Format

```
NN_kata_name/
  README.md               — the smell, the goal, constraints
  name.rb                 — start here, edit freely
  name_test.rb            — do not edit
  name_solution.rb        — reference solution, don't peek
```

## Setup

```sh
bundle install
```

## Running

Run all katas:

```sh
bundle exec rake
```

Run one kata's tests:

```sh
bundle exec ruby 01_extract_method/registration_summary_test.rb
```

Run a single test by line number:

```sh
bundle exec rake 01_extract_method/registration_summary_test.rb:42
```

Watch for changes and re-run automatically:

```sh
bin/watch                                              # all katas
bin/watch 01_extract_method/registration_summary_test.rb  # one kata
```

## Linting and Formatting

```sh
bundle exec rubocop          # lint
bundle exec rubocop -a       # autofix safe offenses
bundle exec stree write **/*.rb  # format
```

## Progression

| # | Kata | Smell |
|---|------|-------|
| 01 | Extract Method | Long method, comments as section headers |
| 02 | Split Responsibility | One class doing two unrelated jobs |
| 03 | Replace Conditional with Polymorphism | Case/if chains that grow with every new type |
| 04 | Replace Temp with Query | Local variables that each compute one thing once |
| 05 | Introduce Parameter Object | Raw hash unpacked into many local variables |
| 06 | Null Object | Nil checks for an optional collaborator scattered across methods |
| 07 | Feature Envy | A method more interested in another object's data than its own |
| 08 | Guard Clause | Deeply nested conditionals (the arrow anti-pattern) |
| 09 | Primitive Obsession | Money as a raw integer with formatting logic repeated |
| 10 | Data Clump | Fields that always travel together but live as separate attributes |
| 11 | Message Chain | Reaching through an object graph two or three hops deep |
| 12 | Collection Pipeline | Imperative loops where Enumerable methods would name the intent |
| 13 | Decompose Conditional | A complex boolean condition that requires translation to understand |
| 14 | Tell Don't Ask | Asking an object's state externally and deciding what to do yourself |
| 15 | Encapsulate Collection | A raw collection exposed via attr_reader that callers can freely mutate |
| 16 | Introduce Value Object | A multi-field concept (day, time, zone) treated as separate raw scalars |
| 17 | Replace Inheritance with Delegation | Inheriting a utility class just to borrow a few methods |
| 18 | Middle Man | A class that does nothing but proxy every call to another object |
| 19 | Query Object | Repeated filter conditions scattered across methods instead of composed |
| 20 | Shotgun Surgery | Adding one new tier forces small edits across four separate methods |

## Rules

1. Tests must stay green the entire time — not just at the end.
2. Refactoring changes *how* code works, not *what* it does. No new behavior.
3. Name the smell before you fix it. The name picks the refactoring.
4. Small steps. Run tests after each one. Revert if something goes red.
