# Reference solution — do not share until after the learner completes the kata.

class VolunteerSchedule
  def initialize(schedule)
    @schedule = schedule
  end

  def status_summary
    "#{role}: #{confirmed_count}/#{needed_count} (#{coverage_pct}%) — #{coverage_label}"
  end

  private

  def role
    @schedule[:role]
  end

  def confirmed_count
    @schedule[:volunteers].count { |v| v[:status] == "confirmed" }
  end

  def needed_count
    @schedule[:needed]
  end

  def coverage_pct
    needed_count > 0 ? (confirmed_count.to_f / needed_count * 100).round : 100
  end

  def coverage_label
    if coverage_pct >= 100
      "Fully staffed"
    elsif coverage_pct >= 60
      "Partially staffed"
    else
      "Understaffed"
    end
  end
end
