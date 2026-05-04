class DonorReport
  def badge_color(tier)
    case tier
    when "bronze"
      "#CD7F32"
    when "silver"
      "#C0C0C0"
    when "gold"
      "#FFD700"
    when "platinum"
      "#E5E4E2"
    end
  end

  def minimum_gift_cents(tier)
    case tier
    when "bronze"
      0
    when "silver"
      50_000
    when "gold"
      100_000
    when "platinum"
      500_000
    end
  end

  def tax_letter_template(tier)
    case tier
    when "bronze"
      "standard_acknowledgment"
    when "silver"
      "silver_acknowledgment"
    when "gold"
      "gold_acknowledgment"
    when "platinum"
      "platinum_acknowledgment"
    end
  end

  def perks(tier)
    case tier
    when "bronze"
      []
    when "silver"
      ["newsletter"]
    when "gold"
      %w[newsletter event_invite]
    when "platinum"
      %w[newsletter event_invite personal_call]
    end
  end
end
