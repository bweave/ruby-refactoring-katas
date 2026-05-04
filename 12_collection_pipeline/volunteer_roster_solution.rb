# Reference solution — do not share until after the learner completes the kata.

class VolunteerRoster
  def initialize(volunteers)
    @volunteers = volunteers
  end

  def confirmed_names
    @volunteers
      .select { |v| v[:status] == "confirmed" }
      .map { |v| "#{v[:first_name]} #{v[:last_name]}" }
  end

  def team_totals
    @volunteers.group_by { |v| v[:team] }.transform_values(&:count)
  end

  def any_declined?
    @volunteers.any? { |v| v[:status] == "declined" }
  end

  def total_hours
    @volunteers.sum { |v| v[:hours] || 0 }
  end
end
