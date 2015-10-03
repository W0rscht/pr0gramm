require 'pr0gramm'
require 'test/unit'

class TestPr0grammRequester < Test::Unit::TestCase
  def test_no_login
    pr0 = Pr0gramm.new

    requester = pr0.requester

    assert_nil(requester.username)
    assert_nil(requester.password)
  end

  def test_login_success
    pr0 = Pr0gramm.new(username: ENV['PR0_USERNAME'], password: ENV['PR0_PASSWORD'])

    requester = pr0.requester

    assert_equal(ENV['PR0_USERNAME'], requester.username)
    assert_equal(ENV['PR0_PASSWORD'], requester.password)
  end

  # def test_login_fail

  #   assert_raise_message("Login as 'cha0s' failed.") {
  #     pr0 = Pr0gramm.new(username: 'cha0s', password: 'fattyb00mb00m')
  #   }
  # end

  def test_subdomains
    pr0 = Pr0gramm.new

    requester = pr0.requester

    assert_equal('https://img.pr0gramm.com/', requester.images_url)
    assert_equal('https://full.pr0gramm.com/', requester.fullsize_url)
    assert_equal('https://thumb.pr0gramm.com/', requester.thumbs_url)
    assert_equal('https://pr0gramm.com/media/badges/', requester.badges_url)
  end

  def test_no_subdomains_and_http
    pr0 = Pr0gramm.new(use_subdomains: false, protocol: 'http')

    requester = pr0.requester

    assert_equal('http://pr0gramm.com/data/images/', requester.images_url)
    assert_equal('http://pr0gramm.com/data/fullsize/', requester.fullsize_url)
    assert_equal('http://pr0gramm.com/data/thumbs/', requester.thumbs_url)
    assert_equal('http://pr0gramm.com/media/badges/', requester.badges_url)
  end
end
