class Pr0gramm

  module Flags

    MAPPING = {
      sfw:  1,
      nsfw: 2,
      nsfl: 4,
    }
    REVERSED_MAPPING = MAPPING.invert

    # integer = Pr0gramm::Flags.integer( [:sfw] )
    # integer = Pr0gramm::Flags.integer( [:nsfw] )
    # integer = Pr0gramm::Flags.integer( [:sfw, :nsfw] )
    # integer = Pr0gramm::Flags.integer( [:nsfl] )
    # integer = Pr0gramm::Flags.integer( [:sfw, :nsfl] )
    # integer = Pr0gramm::Flags.integer( [:nsfw, :nsfl] )
    # integer = Pr0gramm::Flags.integer( [:sfw, :nsfw, :nsfl] )
    def self.integer(array)

      flags = 0
      MAPPING.each { |flag, digit|
        next if !array.include?( flag )
        flags += digit
      }
      flags
    end

    # array = Pr0gramm::Flags.array(1)
    # array = Pr0gramm::Flags.array(2)
    # array = Pr0gramm::Flags.array(3)
    # array = Pr0gramm::Flags.array(4)
    # array = Pr0gramm::Flags.array(5)
    # array = Pr0gramm::Flags.array(6)
    # array = Pr0gramm::Flags.array(7)
    def self.array(integer)

      array = []
      REVERSED_MAPPING.each { |digit, flag|

        next if digit > integer

        array.push( flag )

        integer -= digit
      }

     array
    end

    # symbol = Pr0gramm::Flags.symbol(1)
    # symbol = Pr0gramm::Flags.symbol(2)
    # symbol = Pr0gramm::Flags.symbol(4)
    def self.symbol(integer)
      REVERSED_MAPPING[integer]
    end

  end
end
