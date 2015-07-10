require 'time_difference'

class Pr0gramm

  class User

    attr_reader :email, :invites, :likes_are_public, :mark, :mark_default, :paid_until, :invited

    def initialize(api, user_data)

      @api = api

      @email            = user_data['account']['email']
      @invites          = user_data['account']['invites']
      @likes_are_public = user_data['account']['likesArePublic']
      @mark             = Pr0gramm::Mark.string( user_data['account']['mark'] )
      @mark_default     = Pr0gramm::Mark.string( user_data['account']['markDefault'] )

      if user_data['account']['paidUntil'] > 0
        @paid_until = Time.at( user_data['account']['paidUntil'].to_i ).to_datetime
      end

      @invited = []
      user_data['invited'].each { |invite|
        @invited.push({
          email:   invite['email'],
          mark: Pr0gramm::Mark.string( invite['mark'] ),
          created: Time.at( invite['created'].to_i ).to_datetime
        })
      }
    end
  end
end
