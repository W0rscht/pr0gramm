class Pr0gramm

  class Tag

    attr_reader :id, :tag, :confidence

    def initialize(api, tag_data)

      @api = api

      @id         = tag_data['id']
      @tag        = tag_data['tag']
      @confidence = tag_data['confidence']
    end

    def vote(vote)
      @api.vote('tag', @id, vote)
    end

    def up
      vote(1)
    end

    def down
      vote(-1)
    end
  end
end
