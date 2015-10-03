class Pr0gramm
  module API
    module Profile
      def profile(name = nil)
        unless name
          session_data = session
          name         = session_data[:name]
        end

        parameter = {
          name: name,
          flags: Pr0gramm::Flags.digit(@flags)
        }

        result  = @requester.api_get('/profile/info', parameter)
        Pr0gramm::Profile.new(self, result)
      end
    end
  end
end
