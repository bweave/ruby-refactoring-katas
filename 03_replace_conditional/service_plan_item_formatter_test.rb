require_relative "../test_helper"
require_relative "service_plan_item_formatter"

class ServicePlanItemFormatterTest < Minitest::Test
  def setup
    @formatter = ServicePlanItemFormatter.new
  end

  def test_song_title_only
    item = { type: "song", title: "Great Is Thy Faithfulness" }

    assert_equal "Great Is Thy Faithfulness", @formatter.format(item)
  end

  def test_song_with_key
    item = { type: "song", title: "How Great Thou Art", key: "G" }

    assert_equal "How Great Thou Art — G", @formatter.format(item)
  end

  def test_song_with_key_and_duration
    item = { type: "song", title: "How Great Thou Art", key: "G", duration: 4 }

    assert_equal "How Great Thou Art — G — 4 min", @formatter.format(item)
  end

  def test_song_with_duration_but_no_key
    item = { type: "song", title: "Amazing Grace", duration: 3 }

    assert_equal "Amazing Grace — 3 min", @formatter.format(item)
  end

  def test_prayer_no_duration_no_leader
    item = { type: "prayer", title: "Opening Prayer" }

    assert_equal "Prayer", @formatter.format(item)
  end

  def test_prayer_with_duration
    item = { type: "prayer", title: "Opening Prayer", duration: 3 }

    assert_equal "Prayer (3 min)", @formatter.format(item)
  end

  def test_prayer_with_leader
    item = { type: "prayer", title: "Opening Prayer", leader: "Pastor Dave" }

    assert_equal "Prayer — Pastor Dave", @formatter.format(item)
  end

  def test_prayer_with_duration_and_leader
    item = { type: "prayer", title: "Closing Prayer", duration: 2, leader: "Pastor Dave" }

    assert_equal "Prayer (2 min) — Pastor Dave", @formatter.format(item)
  end

  def test_reading_title_only
    item = { type: "reading", title: "Scripture Reading" }

    assert_equal "Reading: Scripture Reading", @formatter.format(item)
  end

  def test_reading_with_passage
    item = { type: "reading", title: "Scripture Reading", passage: "John 3:16" }

    assert_equal "Reading: Scripture Reading — John 3:16", @formatter.format(item)
  end

  def test_giving_no_note
    item = { type: "giving", title: "Offering" }

    assert_equal "Giving", @formatter.format(item)
  end

  def test_giving_with_note
    item = { type: "giving", title: "Offering", note: "Special missions fund" }

    assert_equal "Giving: Special missions fund", @formatter.format(item)
  end

  def test_unknown_type_uses_title
    item = { type: "video", title: "Welcome Video" }

    assert_equal "Welcome Video", @formatter.format(item)
  end

  def test_unknown_type_with_no_title
    item = { type: "video" }

    assert_equal "Untitled", @formatter.format(item)
  end
end
