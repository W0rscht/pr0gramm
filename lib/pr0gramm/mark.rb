class Pr0gramm
  module Mark
    MAPPING = {
      0 => 'Schwuchtel',
      1 => 'Neuschwuchtel',
      2 => 'Altschwuchtel',
      3 => 'Admin',
      4 => 'Gesperrt',
      5 => 'Moderator',
      6 => 'Fliesentischbesitzer',
      7 => 'Lebende Legende',
      8 => 'pr0wichtler',
      9 => 'Edler Spender'
    }

    # string = Pr0gramm::Mark.string( 0 )
    # string = Pr0gramm::Mark.string( 1 )
    # string = Pr0gramm::Mark.string( 2 )
    # string = Pr0gramm::Mark.string( 3 )
    # string = Pr0gramm::Mark.string( 4 )
    # string = Pr0gramm::Mark.string( 5 )
    # string = Pr0gramm::Mark.string( 6 )
    # string = Pr0gramm::Mark.string( 7 )
    # string = Pr0gramm::Mark.string( 8 )
    # string = Pr0gramm::Mark.string( 9 )
    def self.string(digit)
      MAPPING[digit.to_i]
    end

    # digit = Pr0gramm::Mark.digit( 'Schwuchtel' )
    # digit = Pr0gramm::Mark.digit( 'Neuschwuchtel' )
    # digit = Pr0gramm::Mark.digit( 'Altschwuchtel' )
    # digit = Pr0gramm::Mark.digit( 'Admin' )
    # digit = Pr0gramm::Mark.digit( 'Gesperrt' )
    # digit = Pr0gramm::Mark.digit( 'Moderator' )
    # digit = Pr0gramm::Mark.digit( 'Fliesentischbesitzer' )
    # digit = Pr0gramm::Mark.digit( 'Lebende Legende' )
    # digit = Pr0gramm::Mark.digit( 'pr0wichtler' )
    # digit = Pr0gramm::Mark.digit( 'Edler Spender' )
    def self.digit(string)
      mapping_inverted = MAPPING.invert
      mapping_inverted[string]
    end
  end
end
