# Kata 20 — Shotgun Surgery

## The Smell: One Change Forces Many Small Edits

`DonorReport` handles four pieces of information about each donor tier.
Each piece lives in its own method, and each method has the same shape:

```ruby
def badge_color(tier)
  case tier
  when "bronze" then "#CD7F32"
  when "silver" then "#C0C0C0"
  when "gold"   then "#FFD700"
  when "platinum" then "#E5E4E2"
  end
end

def minimum_gift_cents(tier)
  case tier
  when "bronze"   then 0
  when "silver"   then 50_000
  ...
  end
end
```

Now imagine adding a "diamond" tier. You must open `badge_color`, add a branch.
Open `minimum_gift_cents`, add a branch. Open `tax_letter_template`, add a
branch. Open `perks`, add a branch. Four edits, one change.

That is **Shotgun Surgery**: a single conceptual change triggers small edits
scattered across many methods. Each edit is easy. The danger is that you miss
one — or that a future developer doesn't realize they need to update all four.

This differs from the Replace Conditional with Polymorphism smell (kata 03),
which is one large switch that needs breaking apart. Shotgun Surgery is the
*same* small switch repeated in multiple places.

## Your Goal

Collect all tier-specific data into one place — a hash constant — so that adding
a new tier is a single edit:

```ruby
TIER_DATA = {
  "bronze" => { badge_color: "#CD7F32", minimum_gift_cents: 0, ... },
  "silver" => { badge_color: "#C0C0C0", minimum_gift_cents: 50_000, ... },
  ...
}.freeze
```

Each method on `DonorReport` then becomes a simple lookup:

```ruby
def badge_color(tier)
  tier_data(tier).fetch(:badge_color)
end
```

No `case`, no duplication. The tier's properties travel together, and adding
"diamond" means one new hash entry.

## Constraints

- Do not change `donor_report_test.rb`
- Tests must stay green throughout
- No `case tier` or `when` expressions should remain in `DonorReport` when
  you are done

## Check Your Work

Ask yourself: to add a "diamond" tier with its own color, minimum, template,
and perks — how many lines change? If the answer is "one new hash entry" —
the surgery is no longer shotgun.

## Discussion Questions

1. How is Shotgun Surgery different from the Replace Conditional smell (kata 03), which also involves repeated `case` statements?
2. What's the risk of using `fetch` in `tier_data(tier)` vs. using `[]`? When would each be appropriate?
3. Could `TIER_DATA` be moved to a database or configuration file? What would need to change in the code?

## Going Further

Add a "diamond" tier to `TIER_DATA`. Count the lines changed. Then add a new
*attribute* — say, `invitation_only?` — to every tier at once. Compare that
effort to what it would have taken with the original `case` approach.
