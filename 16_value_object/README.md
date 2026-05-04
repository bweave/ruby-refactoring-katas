# Kata 16 — Introduce Value Object

## The Smell: A Multi-Field Concept Without Identity

`ServiceSchedule` works with service records as raw hashes. Three fields —
`:day`, `:time`, and `:zone` — always appear together, always get passed to the
same private methods together, and define what makes two services "the same
slot":

```ruby
def same_slot?(a, b)
  a[:day] == b[:day] && a[:time] == b[:time] && a[:zone] == b[:zone]
end

def sorted_names
  @services.sort_by { |s| [DAYS.index(s[:day]) || 7, s[:time]] } ...
end
```

And the formatting logic lives on `ServiceSchedule` instead of on the thing
being formatted:

```ruby
def format_time(day, time, zone)
  hour, min = time.split(":").map(&:to_i)
  ...
end
```

The root cause: there is no object that *is* a service time. The concept exists
implicitly in three hash keys. The smell has a name: these three fields want to
be a **Value Object** — an object defined entirely by its values (not by object
identity), with its own formatting, equality, and ordering.

This differs from the Data Clump smell (kata 10), which is about fields that
travel together. Value Object adds behavior: the extracted class knows how to
format itself, compare itself, and sort itself.

## Your Goal

Introduce a `ServiceTime` class that wraps `day`, `time`, and `zone` and owns:

- String representation (`to_s`) — e.g., `"Sunday 8:00 AM CT"`
- Equality (`==`) — two `ServiceTime` objects are equal when all three fields match
- Ordering (`<=>` via `Comparable`) — sort by day-of-week index, then by time string

Once `ServiceTime` exists, `ServiceSchedule` should delegate to it:

```ruby
def display
  @services.map { |name, time| "#{name}: #{time}" }
end

def same_slot?(a, b)
  build(a) == build(b)
end

def sorted_names
  @services.sort_by { |_, time| time }.map { |name, _| name }
end
```

No formatting math, no `DAYS.index`, no zone lookup should remain in
`ServiceSchedule` when you're done.

## Constraints

- Do not change `service_schedule_test.rb`
- Tests must stay green after every step
- All formatting and comparison logic must live on `ServiceTime`, not on `ServiceSchedule`

## Check Your Work

Ask yourself: if the display format changes from `"Sunday 8:00 AM CT"` to
`"Sun 8:00am (CT)"`, which class changes? If the answer is only `ServiceTime` —
and `ServiceSchedule` never opens — the value object owns what it should.
