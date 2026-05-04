# Ruby Katas

Refactoring katas for junior Planning Center developers. Each kata provides
working code with a passing test suite; the learner refactors while keeping
every test green.

## Commands

```sh
bundle exec rake                          # run all tests
bundle exec ruby NN_kata/name_test.rb     # run one kata
bundle exec rake NN_kata/name_test.rb:42  # run one test by line number
bin/watch                                 # watch and re-run all tests
bin/watch NN_kata/name_test.rb            # watch and re-run one kata
bundle exec rubocop -a                    # lint and autofix
bundle exec stree write **/*.rb           # format
```

## Project Structure

```
test_helper.rb            — shared minitest setup (quiet reporter + pride)
NN_kata_name/
  README.md               — smell, goal, constraints for the learner
  name.rb                 — the problem file (messy but working)
  name_test.rb            — immutable; defines done
  name_solution.rb        — reference solution, not shared until after
```

## Adding a Kata

1. Create `NN_kata_name/` directory
2. Write `name.rb` — working code with a clear smell
3. Write `name_test.rb` — open with `require_relative "../test_helper"`; tests must pass against both the problem and solution files
4. Write `name_solution.rb` — the refactored version; prefix with the "do not share" comment
5. Write `README.md` — smell name, goal, constraints, and a "check your work" question
6. Add a row to the progression table in the root `README.md`
7. Run `bundle exec rake` — all tests must pass
8. Run `bundle exec rubocop` and `bundle exec stree write **/*.rb` — no offenses

## Kata Design Rules

- The problem file must be working code with all tests green before the learner touches it
- Tests exercise behavior, not structure — the learner's refactoring should never require editing the test file
- One smell per kata, named explicitly in the README
- The solution demonstrates the canonical fix for that smell — no bonus refactors
- Domain is Planning Center-flavored (check-in, attendance, service plans, giving, volunteers)
