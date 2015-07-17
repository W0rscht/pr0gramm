class Pr0gramm

  class Comment

    attr_reader :id, :name, :content, :confidence, :created, :votes_down, :votes_up, :mark, :parent

    def initialize(api, comment_data)

      @api = api

      @id         = comment_data['id']
      @name       = comment_data['name']
      @content    = comment_data['content']
      @confidence = comment_data['confidence']
      @created    = Time.at( comment_data['created'].to_i ).to_datetime
      @votes_down = comment_data['down']
      @votes_up   = comment_data['up']
      @mark       = comment_data['mark']
      @parent     = comment_data['parent']
    end

    def vote(vote)
      @api.vote('comment', @id, vote)
    end

    def up
      vote(1)
    end

    def down
      vote(-1)
    end
  end
end
