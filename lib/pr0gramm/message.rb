class Pr0gramm
  class Message

    attr_reader :id, :message, :sender_id, :sender_name, :sender_mark, :created

    def initialize(api, message_data)

      @api = api

      @id             = message_data['id']
      @message        = message_data['message']
      @sender_id      = message_data['senderId']
      @sender_name    = message_data['name']
      @sender_mark    = Pr0gramm::Mark.string( message_data['mark'] )
      @created        = Time.at( message_data['created'].to_i ).to_datetime
    end
  end
end