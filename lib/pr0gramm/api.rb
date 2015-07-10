require 'pr0gramm/api/item'
require 'pr0gramm/api/profile'
require 'pr0gramm/api/user'

class Pr0gramm

  module API
    include Pr0gramm::API::Item
    include Pr0gramm::API::Profile
    include Pr0gramm::API::User
  end
end