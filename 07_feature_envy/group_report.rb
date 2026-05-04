Group = Struct.new(:name, :member_count, :inactive_count, keyword_init: true)

class GroupReport
  def membership_summary(group)
    active_count = group.member_count - group.inactive_count
    pct = group.member_count > 0 ? (active_count.to_f / group.member_count * 100).round : 0
    "#{group.name}: #{active_count} active of #{group.member_count} (#{pct}%)"
  end
end
