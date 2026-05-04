# Reference solution — do not share until after the learner completes the kata.

class SongItem
  def initialize(item)
    @item = item
  end

  def format
    parts = [@item[:title]]
    parts << @item[:key] if @item[:key]
    parts << "#{@item[:duration]} min" if @item[:duration]
    parts.join(" — ")
  end
end

class PrayerItem
  def initialize(item)
    @item = item
  end

  def format
    label = @item[:duration] ? "Prayer (#{@item[:duration]} min)" : "Prayer"
    @item[:leader] ? "#{label} — #{@item[:leader]}" : label
  end
end

class ReadingItem
  def initialize(item)
    @item = item
  end

  def format
    passage = @item[:passage] ? " — #{@item[:passage]}" : ""
    "Reading: #{@item[:title]}#{passage}"
  end
end

class GivingItem
  def initialize(item)
    @item = item
  end

  def format
    note = @item[:note] ? ": #{@item[:note]}" : ""
    "Giving#{note}"
  end
end

class UnknownItem
  def initialize(item)
    @item = item
  end

  def format
    @item[:title] || "Untitled"
  end
end

class ServicePlanItemFormatter
  ITEM_CLASSES = {
    "song" => SongItem,
    "prayer" => PrayerItem,
    "reading" => ReadingItem,
    "giving" => GivingItem,
  }.freeze

  def format(item)
    item_class = ITEM_CLASSES.fetch(item[:type], UnknownItem)
    item_class.new(item).format
  end
end
