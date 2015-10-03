require 'pr0gramm'
require 'test/unit'

class TestPr0grammAPIRequest < Test::Unit::TestCase
  def test_items_default
    pr0 = Pr0gramm.new(username: ENV['PR0_USERNAME'], password: ENV['PR0_PASSWORD'])

    items = pr0.items

    assert_equal(120, items.size)
    assert_instance_of(Pr0gramm::Item, items.first)

    promoted = items.select { |item| item.promoted > 0 }
    assert_equal(120, promoted.size)

    sfw = items.select { |item| item.flags == :sfw }
    assert_equal(120, sfw.size)
  end

  def test_items_nsfw
    pr0 = Pr0gramm.new(username: ENV['PR0_USERNAME'], password: ENV['PR0_PASSWORD'])

    items = pr0.items(flags: [:nsfw])

    assert_equal(120, items.size)

    sfw = items.select { |item| item.flags == :nsfw }
    assert_equal(120, sfw.size)
  end

  def test_items_not_promoted
    pr0 = Pr0gramm.new(username: ENV['PR0_USERNAME'], password: ENV['PR0_PASSWORD'])

    items = pr0.items(promoted: false)

    assert_equal(120, items.size)

    not_promoted = items.select { |item| item.promoted == 0 }
    assert_not_equal(120, not_promoted.size)
  end

  def test_item_info
    pr0 = Pr0gramm.new(username: ENV['PR0_USERNAME'], password: ENV['PR0_PASSWORD'])

    item_info = pr0.item_info(879_293)

    assert_equal(667, item_info[:comments].size)
    assert_equal(150, item_info[:tags].size)
  end
end
