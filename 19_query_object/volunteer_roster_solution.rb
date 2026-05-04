# Reference solution — do not share until after the learner completes the kata.

class VolunteerQuery
  def initialize(volunteers)
    @scope = volunteers
  end

  def team(name)
    filter { |v| v[:team] == name }
  end

  def available
    filter { |v| v[:available] }
  end

  def qualified
    filter { |v| v[:qualified] }
  end

  def first_timers
    filter { |v| v[:first_timer] }
  end

  def to_a
    @scope
  end

  private

  def filter(&block)
    self.class.new(@scope.select(&block))
  end
end

class VolunteerRoster
  def initialize(volunteers)
    @volunteers = volunteers
  end

  def available_for(team)
    query.team(team).available.to_a
  end

  def qualified_for(team)
    query.team(team).qualified.to_a
  end

  def ready_for(team)
    query.team(team).available.qualified.to_a
  end

  def first_time_for(team)
    query.team(team).first_timers.to_a
  end

  def names_for(team)
    query.team(team).to_a.map { |v| v[:name] }
  end

  private

  def query
    VolunteerQuery.new(@volunteers)
  end
end
