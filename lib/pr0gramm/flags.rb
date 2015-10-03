class Pr0gramm
  module Flags
    MAPPING = {
      sfw:  1,
      nsfw: 2,
      nsfl: 4
    }
    REVERSED_MAPPING = MAPPING.invert

    # digit = Pr0gramm::Flags.digit( [:sfw] )
    # digit = Pr0gramm::Flags.digit( [:nsfw] )
    # digit = Pr0gramm::Flags.digit( [:sfw, :nsfw] )
    # digit = Pr0gramm::Flags.digit( [:nsfl] )
    # digit = Pr0gramm::Flags.digit( [:sfw, :nsfl] )
    # digit = Pr0gramm::Flags.digit( [:nsfw, :nsfl] )
    # digit = Pr0gramm::Flags.digit( [:sfw, :nsfw, :nsfl] )
    def self.digit(array)
      flags = 0
      MAPPING.each do |flag, digit|
        next unless array.include?(flag)
        flags += digit
      end
      flags
    end

    # array = Pr0gramm::Flags.array(1)
    # array = Pr0gramm::Flags.array(2)
    # array = Pr0gramm::Flags.array(3)
    # array = Pr0gramm::Flags.array(4)
    # array = Pr0gramm::Flags.array(5)
    # array = Pr0gramm::Flags.array(6)
    # array = Pr0gramm::Flags.array(7)
    def self.array(lookup)
      lookup = lookup.to_i

      array = []
      REVERSED_MAPPING.sort_by { |_k, v| v }.each do |digit, flag|
        next if digit > lookup

        array.push(flag)

        lookup -= digit
      end

      array.reverse
    end

    # symbol = Pr0gramm::Flags.symbol(1)
    # symbol = Pr0gramm::Flags.symbol(2)
    # symbol = Pr0gramm::Flags.symbol(4)
    def self.symbol(digit)
      REVERSED_MAPPING[digit]
    end
  end
end
