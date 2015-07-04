class Pr0gramm

  class Comment

    attr_reader :id, :name, :content, :confidence, :created, :down, :up, :mark, :parent

    def initialize(comment_data)

      @id         = comment_data['id']
      @name       = comment_data['name']
      @content    = comment_data['content']
      @confidence = comment_data['confidence']
      @created    = Time.at( comment_data['user']['registered'] ).to_datetime
      @down       = comment_data['down']
      @up         = comment_data['up']
      @mark       = comment_data['mark']
      @parent     = comment_data['parent']
    end
  end
end
