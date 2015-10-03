require 'pr0gramm'
require 'test/unit'

class TestPr0gramm < Test::Unit::TestCase
  def test_initialize_no_param
    pr0 = Pr0gramm.new

    assert_equal([:sfw], pr0.flags)
    assert_true(pr0.promoted)

    assert_instance_of(Pr0gramm::Requester, pr0.requester)
  end

  def test_initialize_param
    pr0 = Pr0gramm.new(flags: [:nsfl], promoted: false)

    assert_equal([:nsfl], pr0.flags)
    assert_false(pr0.promoted)

    assert_instance_of(Pr0gramm::Requester, pr0.requester)
  end
end
