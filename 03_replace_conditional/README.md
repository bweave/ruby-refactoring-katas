# Kata 03 — Replace Conditional with Polymorphism

## The Smell: Case Statement That Grows With Every New Type

`ServicePlanItemFormatter#format` is a `case` statement with one branch per item type.
Every time a new type of service item is added — a video, a communion element,
an offering — someone opens this file and adds another `when` branch.

That's the Open/Closed Principle violation: the class can't be extended without
being modified. The `case` statement is a magnet for future changes.

The smell has a name: **type code in a conditional**. The fix has a name too:
**Replace Conditional with Polymorphism**.

## Your Goal

Create one class per item type, each with a `format` method. Then `ServicePlanItemFormatter`
dispatches to the right class based on type — with no `case` or `if`:

```ruby
def format(item)
  item_class = ITEM_CLASSES.fetch(item[:type], UnknownItem)
  item_class.new(item).format
end
```

Adding a new item type now means adding a new class. The formatter never changes.

## Constraints

- Do not change `service_plan_item_formatter_test.rb`
- Tests must stay green after every step
- No `case`, `if/elsif`, or `respond_to?` chains in `ServicePlanItemFormatter#format`
- Each item class should know about exactly one item type

## Check Your Work

Ask yourself: if a new item type `"video"` is added, which files change?

If the answer is only "I add a new class and register it," the refactoring is complete.
If the answer includes "and I edit the formatter," keep going.

## Discussion Questions

1. When is a `case` statement the right tool, and when is it a smell? What's the difference between switching on type vs. switching on state?
2. Adding a new item type now means adding a new class. What if you need to *remove* an item type? Which approach — `case` vs. polymorphism — handles removal more gracefully?
3. The `ITEM_CLASSES` hash maps type strings to classes. Who decides what to do with an unknown type, and is `UnknownItem` a good name for that class?

## Going Further

Add a `"video"` item type that formats as `"[Video] #{item[:title]} (#{item[:duration]} min)"`.
Notice you only add one class and one hash entry — `ServicePlanItemFormatter` is
untouched. Then add a `"communion"` type. How does the cost of adding a type
compare to the original `case` version?
