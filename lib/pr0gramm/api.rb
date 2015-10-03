require 'pr0gramm/api/item'
require 'pr0gramm/api/profile'
require 'pr0gramm/api/request'
require 'pr0gramm/api/user'

class Pr0gramm
  module API
    include Pr0gramm::API::Item
    include Pr0gramm::API::Profile
    include Pr0gramm::API::Request
    include Pr0gramm::API::User

    def session
      session_data = @requester.session

      fail 'Not logged in.' unless session_data

      session_data
    end
  end
end
