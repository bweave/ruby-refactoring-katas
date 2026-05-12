# Kata 10 — Data Clump

## The Smell: Fields That Always Travel Together

`TeamMember` holds six attributes. Four of them — `street`, `city`, `state`,
`zip` — always appear as a group. `mailing_label`, `address_summary`, and
`same_city?` all work with those four fields and only those four fields.

When a cluster of data items always appears together, always gets passed together,
and triggers behavior together, that cluster is a **Data Clump**. It's really
one thing — an address — masquerading as four separate fields.

The tell: if you removed `street`, `city`, `state`, and `zip` from the class and
replaced them with an `address` object, would the class become simpler? If yes,
the clump wants to be extracted.

## Your Goal

Extract an `Address` class that owns the four fields and the behavior that
operates on them: multi-line formatting for mailing labels, single-line formatting
for summaries, and city comparison. Then simplify `TeamMember` to delegate:

```ruby
def mailing_label
  "#{name}\n#{address.mailing_lines}"
end
```

## Constraints

- Do not change `team_member_test.rb`
- Tests must stay green after every step — extract one method to `Address` at a time
- `TeamMember` should contain no references to `street`, `city`, `state`, or `zip`
  directly when you're done (only through `address`)

## Check Your Work

Ask yourself: if the address format needs to add a country line, which class
changes? If the answer is only `Address` — and `TeamMember` never opens — the
extraction is complete.

## Discussion Questions

1. How is Data Clump different from Primitive Obsession (kata 09)? When does a primitive become a clump?
2. After extracting `Address`, could `Address` itself show a smell? What would it be?
3. What decides whether to make `Address` a `Struct` vs. a plain class?

## Going Further

Add a `country` field to `Address` with a default of `"US"`. Notice that `TeamMember`
is completely unaffected — the change lives entirely in `Address`. Then add a
`formatted_for_envelope` method that includes the country line when it isn't `"US"`.
Again, `TeamMember` doesn't change.
