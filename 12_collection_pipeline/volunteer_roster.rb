class VolunteerRoster
  def initialize(volunteers)
    @volunteers = volunteers
  end

  def confirmed_names
    names = []
    @volunteers.each do |v|
      names << "#{v[:first_name]} #{v[:last_name]}" if v[:status] == "confirmed"
    end
    names
  end

  def team_totals
    totals = {}
    @volunteers.each do |v|
      team = v[:team]
      if totals[team]
        totals[team] += 1
      else
        totals[team] = 1
      end
    end
    totals
  end

  def any_declined?
    found = false
    @volunteers.each { |v| found = true if v[:status] == "declined" }
    found
  end

  def total_hours
    hours = 0
    @volunteers.each { |v| hours += v[:hours] if v[:hours] }
    hours
  end
end
