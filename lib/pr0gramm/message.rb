class Pr0gramm
  class Message
    attr_reader :id, :message, :sender_id, :sender_name, :sender_mark,
                :recipient_id, :recipient_name, :recipient_mark, :created

    def initialize(api, message_data)
      @api = api

      to_instance_vars(message_data)
    end

    def reply(comment)
      @api.private_message(@sender_name, comment)
    end

    private

    def to_instance_vars(message_data)
      message_data = prepare_instance_vars(message_data)

      @id             = message_data['id']
      @message        = message_data['message']
      @sent           = message_data['sent']
      @created        = message_data['created']

      sender_instance_vars(message_data)
      recipient_instance_vars(message_data)
    end

    def prepare_instance_vars(message_data)
      message_data.merge(
        'created'       => Time.at(message_data['created']).to_datetime,
        'senderMark'    => Pr0gramm::Mark.string(message_data['senderMark']),
        'recipientMark' => Pr0gramm::Mark.string(message_data['recipientMark'])
      )
    end

    def sender_instance_vars(message_data)
      @sender_id   = message_data['senderId']
      @sender_name = message_data['senderName']
      @sender_mark = message_data['senderMark']
    end

    def recipient_instance_vars(message_data)
      @recipient_id   = message_data['recipientId']
      @recipient_name = message_data['recipientName']
      @recipient_mark = message_data['recipientMark']
    end
  end
end
