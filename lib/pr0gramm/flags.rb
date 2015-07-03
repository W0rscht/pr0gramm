class Pr0gramm

  module Flags

    # integer = Pr0gramm::Flags.integer( [:sfw] )
    # integer = Pr0gramm::Flags.integer( [:nsfw] )
    # integer = Pr0gramm::Flags.integer( [:sfw, :nsfw] )
    # integer = Pr0gramm::Flags.integer( [:nsfl] )
    # integer = Pr0gramm::Flags.integer( [:sfw, :nsfl] )
    # integer = Pr0gramm::Flags.integer( [:nsfw, :nsfl] )
    # integer = Pr0gramm::Flags.integer( [:sfw, :nsfw, :nsfl] )
    def self.integer(array)

      flags  = 0
      flags += 1 if array.include?(:sfw)
      flags += 2 if array.include?(:nsfw)
      flags += 4 if array.include?(:nsfl)

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

      mapping = {
        4 => :nsfl,
        2 => :nsfw,
        1 => :sfw,
      }

      array = []
      mapping.each { |digit, flag|

        next if digit > integer

        array.push( flag )

        integer -= digit
      }

     array
    end
  end
end
