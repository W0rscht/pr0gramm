class Pr0gramm
  module API
    module User
      def user
        session

        result = @requester.api_get('/user/info')
        Pr0gramm::User.new(self, result)
      end

      def inbox(inbox_type = :all)
        session

        result = @requester.api_get("/inbox/#{inbox_type}")

        # TODO: result['hasNewer']
        # TODO: result['hasOlder']

        @messages = []
        result['messages'].each do |message|
          next if message['itemId']
          # TODO: comment lookup to Pr0gramm::Comment
          # @item_id    = message['itemId']
          # @name       = message['name']
          # @mark       = Pr0gramm::Mark.string( message['mark'] )
          # @score      = message['score']
          # @thumb_path = message['thumb']
          # @thumb_url  = "#{@api.requester.thumbs_url}#{thumb_path}"

          @messages.push(Pr0gramm::Message.new(self, message))
        end

        @messages
      end

      def private_message(recipient, comment)
        session_data = session

        profile = profile(recipient)

        parameter = {
          recipientId: profile.id,
          comment:     comment,
          _nonce:      session_data[:nonce]
        }

        @requester.api_post('/inbox/post', parameter)

        nil
      end

      def following
        session_data = session

        fail 'Pr0mium needed to use that feature.' unless session_data[:paid]

        items(following: true, promoted: false)
      end

      def settings_site(settings = {})
        session_data = session

        # TODO: refactor
        user_status = 'default'
        if session_data
          if session_data[:paid] && user.mark == 'Edler Spender'
            user_status = 'paid'
          end
        end

        parameter = build_settings_paramter(settings, user_status)

        @requester.api_post('/user/sitesettings', parameter)

        nil
      end

      def request_email_change(new_email)
        session_data = session

        parameter = {
          _nonce:          session_data[:nonce],
          currentPassword: @requester.password,
          email:           new_email
        }

        @requester.api_post('/user/requestemailchange', parameter)

        nil
      end

      def invite(email)
        session_data = session

        parameter = {
          _nonce: session_data[:nonce],
          email:  email
        }

        @requester.api_post('/user/invite', parameter)

        nil
      end

      private

      def build_settings_paramter(settings, user_status)
        session_data = session
        settings     = merge_settings(settings, user_status)

        {
          likesArePublic: settings[:likes_are_public] ? 1 : 0,
          userStatus:     settings[:user_status],
          showAds:        0, # sorry cha0s, only valid for current session
          _nonce:         session_data[:nonce]
        }
      end

      def merge_settings(settings, user_status)
        user_data = user

        {
          likes_are_public: user_data.likes_are_public,
          user_status:      user_status
        }.merge(settings)
      end
    end
  end
end
