# Reference solution — do not share until after the learner completes the kata.

class Group
  attr_reader :name, :member_count, :inactive_count

  def initialize(name:, member_count:, inactive_count:)
    @name = name
    @member_count = member_count
    @inactive_count = inactive_count
  end

  def active_count
    member_count - inactive_count
  end

  def active_pct
    member_count > 0 ? (active_count.to_f / member_count * 100).round : 0
  end

  def membership_summary
    "#{name}: #{active_count} active of #{member_count} (#{active_pct}%)"
  end
end

class GroupReport
  def membership_summary(group)
    group.membership_summary
  end
end
