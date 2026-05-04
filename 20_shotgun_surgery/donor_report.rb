class DonorReport
  def badge_color(tier)
    case tier
    when "bronze" then "#CD7F32"
    when "silver" then "#C0C0C0"
    when "gold" then "#FFD700"
    when "platinum" then "#E5E4E2"
    end
  end

  def minimum_gift_cents(tier)
    case tier
    when "bronze" then 0
    when "silver" then 50_000
    when "gold" then 100_000
    when "platinum" then 500_000
    end
  end

  def tax_letter_template(tier)
    case tier
    when "bronze" then "standard_acknowledgment"
    when "silver" then "silver_acknowledgment"
    when "gold" then "gold_acknowledgment"
    when "platinum" then "platinum_acknowledgment"
    end
  end

  def perks(tier)
    case tier
    when "bronze" then []
    when "silver" then ["newsletter"]
    when "gold" then ["newsletter", "event_invite"]
    when "platinum" then ["newsletter", "event_invite", "personal_call"]
    end
  end
end
