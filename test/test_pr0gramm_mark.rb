require 'pr0gramm'
require 'test/unit'

class TestPr0grammMark < Test::Unit::TestCase
  def test_string
    assert_equal('Schwuchtel', Pr0gramm::Mark.string(0))
    assert_equal('Neuschwuchtel', Pr0gramm::Mark.string(1))
    assert_equal('Altschwuchtel', Pr0gramm::Mark.string(2))
    assert_equal('Admin', Pr0gramm::Mark.string(3))
    assert_equal('Gesperrt', Pr0gramm::Mark.string(4))
    assert_equal('Moderator', Pr0gramm::Mark.string(5))
    assert_equal('Fliesentischbesitzer', Pr0gramm::Mark.string(6))
    assert_equal('Lebende Legende', Pr0gramm::Mark.string(7))
    assert_equal('pr0wichtler', Pr0gramm::Mark.string(8))
    assert_equal('Edler Spender', Pr0gramm::Mark.string(9))
  end

  def test_digit
    assert_equal(0, Pr0gramm::Mark.digit('Schwuchtel'))
    assert_equal(1, Pr0gramm::Mark.digit('Neuschwuchtel'))
    assert_equal(2, Pr0gramm::Mark.digit('Altschwuchtel'))
    assert_equal(3, Pr0gramm::Mark.digit('Admin'))
    assert_equal(4, Pr0gramm::Mark.digit('Gesperrt'))
    assert_equal(5, Pr0gramm::Mark.digit('Moderator'))
    assert_equal(6, Pr0gramm::Mark.digit('Fliesentischbesitzer'))
    assert_equal(7, Pr0gramm::Mark.digit('Lebende Legende'))
    assert_equal(8, Pr0gramm::Mark.digit('pr0wichtler'))
    assert_equal(9, Pr0gramm::Mark.digit('Edler Spender'))
  end
end
