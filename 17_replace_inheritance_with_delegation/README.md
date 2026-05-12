# Kata 17 — Replace Inheritance with Delegation

## The Smell: Inheriting to Borrow Utilities

`AttendanceExporter` inherits from `ReportFormatter`:

```ruby
class AttendanceExporter < ReportFormatter
```

Why? Not because an exporter *is* a formatter, or because it specializes any
formatting behavior. It inherits solely to borrow three utility methods —
`format_count`, `format_percentage`, and `divider` — so it can call them
without a receiver:

```ruby
lines << "#{format_count(r[:total], "person", "people")} ..."
lines << divider
```

This is inheritance as a shortcut, not inheritance as a relationship. The
problems it creates:

- Any other class that needs `ReportFormatter`'s utilities must also inherit,
  collapsing unrelated classes into the same hierarchy.
- `AttendanceExporter` inherits the full `ReportFormatter` interface even
  though it only uses three methods.
- Replacing or testing the formatting logic requires subclassing or patching
  the superclass.

The principle: **favor composition over inheritance**. Inherit when you are
truly extending a class — when you want to be used anywhere the parent is used.
Delegate when you just want to *use* a collaborator's behavior.

## Your Goal

Break the inheritance link. Give `AttendanceExporter` a `formatter` collaborator
instead of a parent class:

```ruby
class AttendanceExporter
  def initialize(records, formatter: ReportFormatter.new)
    @records = records
    @formatter = formatter
  end
end
```

Then update every method call that previously relied on inherited methods to go
through `@formatter`:

```ruby
@formatter.format_count(...)
@formatter.divider
```

## A Note on Dependency Injection

The `formatter:` keyword argument is **dependency injection** — the collaborator
is supplied from outside rather than instantiated inside. This is the Dependency
Inversion Principle (the D in SOLID) in action: `AttendanceExporter` depends on
an abstraction (any object that responds to `format_count`, `format_percentage`,
`divider`) rather than a concrete class. The default value keeps callers who don't
care about formatting simple, while still leaving the door open for tests and
alternate implementations to supply a different formatter.

## Constraints

- Do not change `attendance_exporter_test.rb`
- Tests must stay green after every step — remove the `< ReportFormatter` last
- `AttendanceExporter` must not inherit from `ReportFormatter` when you are done

## Check Your Work

Ask yourself: if you wanted to swap `ReportFormatter` for a `CsvFormatter` that
formats counts differently, which class would you change? If the answer is
"pass a different object to the constructor" — with no changes to
`AttendanceExporter` — the delegation is doing its job.
