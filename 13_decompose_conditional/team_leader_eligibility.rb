class TeamLeaderEligibility
  def eligible?(volunteer)
    volunteer[:years_serving] >= 2 && volunteer[:background_check] == "cleared" &&
      !volunteer[:on_leave] && volunteer[:training_complete] && volunteer[:attendance_pct] >= 75
  end

  def ineligible_reason(volunteer)
    if volunteer[:years_serving] < 2
      "Needs at least 2 years of service"
    elsif volunteer[:background_check] != "cleared"
      "Background check not cleared"
    elsif volunteer[:on_leave]
      "Currently on leave"
    elsif !volunteer[:training_complete]
      "Training not complete"
    elsif volunteer[:attendance_pct] < 75
      "Attendance below 75%"
    end
  end
end
