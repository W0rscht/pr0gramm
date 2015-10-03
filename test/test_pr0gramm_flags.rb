require 'pr0gramm'
require 'test/unit'

class TestPr0grammFlags < Test::Unit::TestCase
  def test_symbol
    assert_equal(:sfw, Pr0gramm::Flags.symbol(1))
    assert_equal(:nsfw, Pr0gramm::Flags.symbol(2))
    assert_equal(:nsfl, Pr0gramm::Flags.symbol(4))
  end

  def test_digit
    assert_equal(1, Pr0gramm::Flags.digit([:sfw]))
    assert_equal(2, Pr0gramm::Flags.digit([:nsfw]))
    assert_equal(3, Pr0gramm::Flags.digit([:sfw, :nsfw]))
    assert_equal(4, Pr0gramm::Flags.digit([:nsfl]))
    assert_equal(5, Pr0gramm::Flags.digit([:sfw, :nsfl]))
    assert_equal(6, Pr0gramm::Flags.digit([:nsfw, :nsfl]))
    assert_equal(7, Pr0gramm::Flags.digit([:sfw, :nsfw, :nsfl]))
  end

  def test_array
    assert_equal([:sfw], Pr0gramm::Flags.array(1))
    assert_equal([:nsfw], Pr0gramm::Flags.array(2))
    assert_equal([:sfw, :nsfw], Pr0gramm::Flags.array(3))
    assert_equal([:nsfl], Pr0gramm::Flags.array(4))
    assert_equal([:sfw, :nsfl], Pr0gramm::Flags.array(5))
    assert_equal([:nsfw, :nsfl], Pr0gramm::Flags.array(6))
    assert_equal([:sfw, :nsfw, :nsfl], Pr0gramm::Flags.array(7))
  end
end
