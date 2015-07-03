class Pr0gramm

  class User

  MARK_MAPPING = {
    '0' => 'Schwuchtel',
    '1' => 'Neuschwuchtel',
    '2' => 'Altschwuchtel',
    '3' => 'Admin',
    '4' => 'Gesperrt',
    '5' => 'Moderator',
    '6' => 'Fliesentischbesitzer',
    '7' => 'Lebende Legende',
    '8' => 'pr0wichtler',
    '9' => 'Edler Spender',
  }

  attr_reader :id, :name, :registered, :score, :mark, :admin, :banned, :comments

  def initialize(name)


    # http://pr0gramm.com/api/profile/info?name=GermanLeviathan

    # @id =
    # @name =
    # @registered =
    # @score =
    # @mark =
    # @admin =
    # @banned =
  end
end
