class ServicePlanItemFormatter
  def format(item)
    case item[:type]
    when "song"
      parts = [item[:title]]
      parts << item[:key] if item[:key]
      parts << "#{item[:duration]} min" if item[:duration]
      parts.join(" — ")
    when "prayer"
      label = item[:duration] ? "Prayer (#{item[:duration]} min)" : "Prayer"
      item[:leader] ? "#{label} — #{item[:leader]}" : label
    when "reading"
      passage = item[:passage] ? " — #{item[:passage]}" : ""
      "Reading: #{item[:title]}#{passage}"
    when "giving"
      note = item[:note] ? ": #{item[:note]}" : ""
      "Giving#{note}"
    else
      item[:title] || "Untitled"
    end
  end
end
