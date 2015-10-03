require 'pr0gramm'
require 'test/unit'

class TestPr0grammProfile < Test::Unit::TestCase
  def test_own_not_logged_in
    pr0 = Pr0gramm.new

    assert_raise_message('Not logged in.') do
      pr0.profile
    end
  end

  def test_own
    pr0 = Pr0gramm.new(username: ENV['PR0_USERNAME'], password: ENV['PR0_PASSWORD'])

    profile = pr0.profile

    assert_equal(ENV['PR0_USERNAME'], profile.name)
    assert_equal('Thu, 02 Jul 2015 18:45:46 +0200'.to_datetime, profile.registered)
    assert_equal(46, profile.score)
    assert_equal('Neuschwuchtel', profile.mark)
    assert_equal(false, profile.admin)
    assert_equal(false, profile.banned)
    assert_equal(0, profile.comment_count)
    assert_equal(1, profile.upload_count)
    assert_equal(1, profile.like_count)
    assert_equal(6, profile.tag_count)
    assert_equal(0, profile.follow_count)
    assert_equal(true, profile.likes_are_public)
    assert_equal(false, profile.following)
    assert_equal([], profile.badges)
  end

  def test_cha0s
    pr0 = Pr0gramm.new

    profile = pr0.profile('cha0s')

    assert_equal('cha0s', profile.name)
    assert_equal('Sun, 14 Oct 2007 01:10:19 +0200'.to_datetime, profile.registered)
    assert_equal('Admin', profile.mark)
    assert_equal(true, profile.admin)
    assert_equal(false, profile.banned)
    assert_equal(1229, profile.comment_count)
    assert_equal(1564, profile.upload_count)
    assert_equal(1134, profile.like_count)
    assert_equal(1630, profile.tag_count)
    assert_equal(0, profile.follow_count)
    assert_equal(true, profile.likes_are_public)
    assert_equal(false, profile.following)

p profile.badges.inspect

    assert_equal(2, profile.badges.size)
  end
end
