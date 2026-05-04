class VolunteerSchedule
  def initialize(schedule)
    @schedule = schedule
  end

  def status_summary
    confirmed_count = @schedule[:volunteers].count { |v| v[:status] == "confirmed" }
    needed_count = @schedule[:needed]
    coverage_pct = needed_count > 0 ? (confirmed_count.to_f / needed_count * 100).round : 100
    label =
      if coverage_pct >= 100
        "Fully staffed"
      elsif coverage_pct >= 60
        "Partially staffed"
      else
        "Understaffed"
      end
    "#{@schedule[:role]}: #{confirmed_count}/#{needed_count} (#{coverage_pct}%) — #{label}"
  end
end
