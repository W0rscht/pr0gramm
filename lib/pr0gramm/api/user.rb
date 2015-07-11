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

      def following

        session_data = session
        fail 'Not logged in.' if !session_data

        fail 'You need to be a pr0mium user to use that feature.' if !session_data[:paid]

        items({ following: true, promoted: nil })
      end

      def settings_site( settings = {} )

        session_data = session
        fail 'Not logged in.' if !session_data

        user_data = user

        # TODO: refactor
        user_status = 'default'
        if session_data
          if session_data[:paid] && user.mark == 'Edler Spender'
            user_status = 'paid'
          end
        end

        settings = {
          likes_are_public: user_data.likes_are_public,
          user_status:      user_status
        }.merge(settings)

        parameter = {
          likesArePublic: settings[:likes_are_public] ? 1 : 0,
          userStatus:     settings[:user_status],
          showAds:        0, # sorry cha0s, only valid for current session
          _nonce:         session_data[:nonce],
        }

        @requester.api_post('/user/sitesettings', parameter)

        nil
      end

      def request_email_change( new_email )

        session_data = session
        fail 'Not logged in.' if !session_data

        parameter = {
          _nonce:          session_data[:nonce],
          currentPassword: @requester.password,
          email:           new_email
        }

        @requester.api_post('/user/requestemailchange', parameter)

        nil
      end

    end
  end
end