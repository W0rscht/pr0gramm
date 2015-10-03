require 'time_difference'

class Pr0gramm
  class User
    attr_reader :email, :invites, :likes_are_public, :mark,
                :mark_default, :paid_until, :invited

    def initialize(api, user_data)
      @api = api

      to_instance_vars(user_data['account'])
    end

    private

    def to_instance_vars(account_data)
      account_data = prepare_instance_vars(account_data)

      @email            = account_data['email']
      @invites          = account_data['invites']
      @likes_are_public = account_data['likesArePublic']
      @mark             = account_data['mark']
      @mark_default     = account_data['markDefault']
      @paid_until       = account_data['paidUntil']

      to_invited(user_data['invited'])
    end

    def prepare_instance_vars(account_data)
      if account_data['paidUntil'] <= 0
        account_data['paidUntil'].delete
      else
        paid_until_unix           = account_data['paidUntil'].to_i
        account_data['paidUntil'] = Time.at(paid_until_unix).to_datetime
      end

      account_data.merge(
        'mark'        => Pr0gramm::Mark.string(account_data['mark']),
        'markDefault' => Pr0gramm::Mark.string(account_data['markDefault'])
      )
    end

    def to_invited(list)
      @invited = []
      list.each do |invite|
        @invited.push(email:   invite['email'],
                      mark:    Pr0gramm::Mark.string(invite['mark']),
                      created: Time.at(invite['created'].to_i).to_datetime)
      end
    end
  end
end
