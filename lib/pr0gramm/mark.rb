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
      9 => 'Edler Spender',
    }

    # string = Pr0gramm::Flags.string( 0 )
    # string = Pr0gramm::Flags.string( 1 )
    # string = Pr0gramm::Flags.string( 2 )
    # string = Pr0gramm::Flags.string( 3 )
    # string = Pr0gramm::Flags.string( 4 )
    # string = Pr0gramm::Flags.string( 5 )
    # string = Pr0gramm::Flags.string( 6 )
    # string = Pr0gramm::Flags.string( 7 )
    # string = Pr0gramm::Flags.string( 8 )
    # string = Pr0gramm::Flags.string( 9 )
    def self.string(integer)
      return MAPPING[ integer.to_i ]
    end

    # integer = Pr0gramm::Flags.integer( 'Schwuchtel' )
    # integer = Pr0gramm::Flags.integer( 'Neuschwuchtel' )
    # integer = Pr0gramm::Flags.integer( 'Altschwuchtel' )
    # integer = Pr0gramm::Flags.integer( 'Admin' )
    # integer = Pr0gramm::Flags.integer( 'Gesperrt' )
    # integer = Pr0gramm::Flags.integer( 'Moderator' )
    # integer = Pr0gramm::Flags.integer( 'Fliesentischbesitzer' )
    # integer = Pr0gramm::Flags.integer( 'Lebende Legende' )
    # integer = Pr0gramm::Flags.integer( 'pr0wichtler' )
    # integer = Pr0gramm::Flags.integer( 'Edler Spender' )
    def self.integer(string)
      mapping_inverted = MAPPING.invert
      return mapping_inverted[ string ]
    end

  end
end
