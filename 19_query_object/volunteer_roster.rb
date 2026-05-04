class VolunteerRoster
  def initialize(volunteers)
    # volunteers: [{name:, team:, available:, qualified:, first_timer:}, ...]
    @volunteers = volunteers
  end

  def available_for(team)
    @volunteers.select { |v| v[:available] && v[:team] == team }
  end

  def qualified_for(team)
    @volunteers.select { |v| v[:qualified] && v[:team] == team }
  end

  def ready_for(team)
    @volunteers.select { |v| v[:available] && v[:qualified] && v[:team] == team }
  end

  def first_time_for(team)
    @volunteers.select { |v| v[:first_timer] && v[:team] == team }
  end

  def names_for(team)
    @volunteers.select { |v| v[:team] == team }.map { |v| v[:name] }
  end
end
