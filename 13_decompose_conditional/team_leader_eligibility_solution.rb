# Reference solution — do not share until after the learner completes the kata.

class TeamLeaderEligibility
  def eligible?(volunteer)
    meets_tenure?(volunteer) && background_cleared?(volunteer) && available?(volunteer) &&
      training_complete?(volunteer) && regular_attender?(volunteer)
  end

  def ineligible_reason(volunteer)
    return "Needs at least 2 years of service" unless meets_tenure?(volunteer)
    return "Background check not cleared" unless background_cleared?(volunteer)
    return "Currently on leave" unless available?(volunteer)
    return "Training not complete" unless training_complete?(volunteer)
    "Attendance below 75%" unless regular_attender?(volunteer)
  end

  private

  def meets_tenure?(volunteer)
    volunteer[:years_serving] >= 2
  end

  def background_cleared?(volunteer)
    volunteer[:background_check] == "cleared"
  end

  def available?(volunteer)
    !volunteer[:on_leave]
  end

  def training_complete?(volunteer)
    volunteer[:training_complete]
  end

  def regular_attender?(volunteer)
    volunteer[:attendance_pct] >= 75
  end
end
