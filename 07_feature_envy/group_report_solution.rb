# Reference solution — do not share until after the learner completes the kata.

Group = Struct.new(:name, :member_count, :inactive_count, keyword_init: true) do
  def active_count
    member_count - inactive_count
  end

  def percent_active
    member_count > 0 ? (active_count.to_f / member_count * 100).round : 0
  end

  def membership_summary
    "#{name}: #{active_count} active of #{member_count} (#{percent_active}%)"
  end
end

class GroupReport
  def membership_summary(group)
    group.membership_summary
  end
end
