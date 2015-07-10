class Pr0gramm
  module API
    module Profile

      def profile(name = nil)

        if !name
          session_data = session
          fail 'Not logged in. Missing username to request.' if !session_data
          name = session_data[:name]
        end

        result  = @requester.api_get('/profile/info', { name: name, flags: Pr0gramm::Flags.integer( @flags ) })
        profile = Pr0gramm::Profile.new( self, result )

        profile
      end

    end
  end
end