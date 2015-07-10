class Pr0gramm
  class Message

    attr_reader :id, :message, :sender_id, :created, :sent, :sender_name, :sender_mark,
                :recipient_name, :recipient_mark, :recipient_id

    def initialize(api, message_data)

      @api = api

      @id             = message_data['id']
      @message        = message_data['message']
      @sender_id      = message_data['senderId']
      @created        = Time.at( message_data['created'].to_i ).to_datetime
      @sent           = message_data['sent']
      @sender_name    = message_data['senderName']
      @sender_mark    = Pr0gramm::Mark.string(  message_data['senderMark'] )
      @recipient_name = message_data['recipientName']
      @recipient_mark = Pr0gramm::Mark.string(  message_data['recipientMark'] )
      @recipient_id   = message_data['recipientId']
    end
  end
end