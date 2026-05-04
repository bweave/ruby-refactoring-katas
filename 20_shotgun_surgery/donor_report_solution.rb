# Reference solution — do not share until after the learner completes the kata.

TIER_DATA = {
  "bronze" => {
    badge_color: "#CD7F32",
    minimum_gift_cents: 0,
    tax_letter_template: "standard_acknowledgment",
    perks: [],
  },
  "silver" => {
    badge_color: "#C0C0C0",
    minimum_gift_cents: 50_000,
    tax_letter_template: "silver_acknowledgment",
    perks: ["newsletter"],
  },
  "gold" => {
    badge_color: "#FFD700",
    minimum_gift_cents: 100_000,
    tax_letter_template: "gold_acknowledgment",
    perks: %w[newsletter event_invite],
  },
  "platinum" => {
    badge_color: "#E5E4E2",
    minimum_gift_cents: 500_000,
    tax_letter_template: "platinum_acknowledgment",
    perks: %w[newsletter event_invite personal_call],
  },
}.freeze

class DonorReport
  def badge_color(tier)
    tier_data(tier).fetch(:badge_color)
  end

  def minimum_gift_cents(tier)
    tier_data(tier).fetch(:minimum_gift_cents)
  end

  def tax_letter_template(tier)
    tier_data(tier).fetch(:tax_letter_template)
  end

  def perks(tier)
    tier_data(tier).fetch(:perks)
  end

  private

  def tier_data(tier)
    TIER_DATA.fetch(tier)
  end
end
