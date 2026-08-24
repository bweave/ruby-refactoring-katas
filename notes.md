# Notes from trying it

- Add the debug gem and require it in test_helper.rb
- Each excercise should include some questions for thought and discussion.
- It might be nice to have a few examples for each exercise. For example when extracting a method, it might be nice to have the simple version and then one or two more complex versions where the extraction isn't quite as obvious.
- Is Kata 05 "data clump"? If so, let's be sure to use that language.
- Kata 06 is a weak example because a Null Object isn't *required* to fix the smell. Let's make a better example.
- In Kata 07, it's not necessary to convert Group from a Struct to a Class.
- In kata 09, is Comparable really needed in the Money class? Also, let's use `@pledges.sum(Money.new(0)) { ... }` instead of `reduce`.
- In kata 10, either call it Registration or EventRegistration. Pick one.
- In kata 15, the changes needed are VERY minimal. It's worth calling that out and making it clear that understanding the concept is the key, and this example just happens to not need much about it changed.
- In kata 17, make a note in the README about using dependency injection to give AttendanceExporter its report formatting collaborator. This is good SOLID design.
