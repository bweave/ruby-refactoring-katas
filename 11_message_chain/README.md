# Kata 11 — Message Chain

## The Smell: Reaching Through Objects

`RegistrationBadge#label` builds its output by chaining through an object
graph it has no business navigating:

```ruby
@registration.person.full_name          # two hops
@registration.event.campus.name         # three hops
```

Each dot after the first means the method knows something it shouldn't: that a
registration has a person, that a person has a full_name, that a registration
has an event, that an event has a campus, that a campus has a name. A method
this far into someone else's neighborhood is violating the **Law of Demeter**:
only talk to your immediate collaborators.

The tell: `a.b.c.d` — any method chain of three or more that isn't a fluent
builder is a message chain.

## Your Goal

Add delegation methods to `EventRegistration` so that `RegistrationBadge` only needs
to call methods directly on `@registration`. `EventRegistration` knows how to find
the person's name and the campus name — the badge doesn't need to know how:

```ruby
def label
  "#{@registration.person_name} — #{@registration.role} — #{@registration.campus_name}"
end
```

## Constraints

- Do not change `registration_badge_test.rb`
- Tests must stay green after every step
- `RegistrationBadge#label` must not traverse more than one object deep when
  you're done — no `@registration.something.something`

## Check Your Work

Ask yourself: if `Person` is replaced by a different object with a different
method name, which class changes? If the answer is `EventRegistration` — and
`RegistrationBadge` never needs to open — the chain is broken.

## Discussion Questions

1. After adding delegation methods to `EventRegistration`, do the new methods feel natural on that class, or are they "borrowed" behavior that belongs elsewhere?
2. What would break — and in which class — if `Event` switched from having a `campus` to having a `location`?
3. How does Message Chain relate to the Law of Demeter? Are there cases where following the Law of Demeter too strictly creates its own problems?

## Going Further

Add an `event_title` delegation method to `EventRegistration` so that
`RegistrationBadge` can include the event title in the label without knowing
about `@registration.event.title`. Notice `RegistrationBadge` gains new data
without reaching through the object graph.
