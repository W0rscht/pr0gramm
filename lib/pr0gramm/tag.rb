class Pr0gramm

  class Tag

    attr_reader :id, :tag, :confidence

    def initialize(tag_data)

      @id         = tag_data['id']
      @tag        = tag_data['tag']
      @confidence = tag_data['confidence']
    end
  end
end
