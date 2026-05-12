# Kata 01 — Extract Method

## The Smell: Long Method

`RegistrationSummary#summary_line` does three separate jobs in sequence:

1. Figures out what name to display
2. Translates a status code into a label
3. Calculates and formats the balance

The inline comments are a dead giveaway — when you need comments to label *sections*
of a method, those sections want to be methods.

## Your Goal

Extract one private method per job. Name each one for *what it does*, not *how*.

When you're done, `summary_line` should read like a sentence:

```ruby
def summary_line(registration)
  "#{display_name(registration)} — #{status_label(registration)} — #{balance_label(registration)}"
end
```

## Constraints

- Do not change `problem_test.rb`
- Tests must stay green after every extraction, not just at the end
- Each extracted method should do exactly one thing

## Check your work

Ask yourself: if a new developer reads only the method names, do they understand
what `summary_line` does without reading the implementations?

## Discussion Questions

1. How do you decide what to name an extracted method? What makes a name good or bad?
2. `summary_line` now reads like a sentence of method calls. What would it look like if you extracted *too far* — each extracted method further extracting still more methods?
3. The three sections were separated by comments before. What does that tell you about whether they were ready to extract?

## Going Further

The current method has three clearly separated jobs with no shared state between
them. A harder case: a method where two sections share a local variable. Try
splitting `summary_line` further by making each extracted method accept only
what it needs as arguments, forcing you to name the inputs explicitly.
