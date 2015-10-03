class Pr0gramm
  class Comment
    attr_reader :id, :name, :content, :confidence, :created,
                :votes_down, :votes_up, :mark, :parent

    def initialize(api, item_id, comment_data)
      @api = api

      @item_id = item_id

      to_instance_vars(comment_data)
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

    def reply(comment)
      @api.comment(@item_id, comment, @id)
    end

    private

    def to_instance_vars(comment_data)
      @id         = comment_data['id']
      @name       = comment_data['name']
      @content    = comment_data['content']
      @confidence = comment_data['confidence']
      @created    = Time.at(comment_data['created'].to_i).to_datetime
      @votes_down = comment_data['down']
      @votes_up   = comment_data['up']
      @mark       = comment_data['mark']
      @parent     = comment_data['parent']
    end
  end
end
