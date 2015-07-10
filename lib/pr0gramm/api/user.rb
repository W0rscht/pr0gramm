class Pr0gramm
  module API
    module User

      def session
        @requester.session
      end

      def user
        fail 'Not logged in.' if !session

        result = @requester.api_get('/user/info')
        Pr0gramm::User.new(self, result)
      end

      def inbox( inbox_type = :all )

        fail 'Not logged in.' if !session

        result = @requester.api_get("/inbox/#{inbox_type}")

        # TODO: result['hasNewer']
        # TODO: result['hasOlder']

        @messages = []
        result['messages'].each { |message|

          next if message['itemId']
          # TODO: comment lookup to Pr0gramm::Comment
          # @item_id    = message['itemId']
          # @name       = message['name']
          # @mark       = Pr0gramm::Mark.string( message['mark'] )
          # @score      = message['score']
          # @thumb_path = message['thumb']
          # @thumb_url  = "#{@api.requester.thumbs_url}#{thumb_path}"

          @messages.push( Pr0gramm::Message.new( self, message ) )
        }

        @messages
      end

    end
  end
end