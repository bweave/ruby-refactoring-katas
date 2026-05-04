class MatchingGiftChecker
  def eligible?(person, gift)
    if person[:active]
      if gift[:amount_cents] >= 1000
        if person[:employer_matching_enabled]
          if gift[:amount_cents] <= person[:matching_limit_cents]
            true
          else
            false
          end
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end
end
