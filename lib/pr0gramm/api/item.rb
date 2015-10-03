require 'uri'
require 'mime/types'

class Pr0gramm
  module API
    module Item
      ALLOWED_UPLOAD_TYPES = [
        'image/png',
        'image/jpeg',
        'image/gif',
        'video/webm'
      ]

      def upload(file, flag, tags, check_similar = true)
        parameter = build_parameter(file, flag, tags, check_similar)

        result = @requester.api_post('/items/post', parameter)

        # TODO: Pr0gramm::Item.new?
        return result['similar'] if result['similar']

        fail "Upload error: #{result['error']}." if result['error']

        # TODO: Pr0gramm::Item.new?
        result['item']['id']
      end

      def vote(object, id, vote)
        session_data = session

        parameter = {
          _nonce: session_data[:nonce],
          id:     id,
          vote:   vote
        }

        @requester.api_post("/#{object}s/vote", parameter)
        nil
      end

      def tag(item_id, tags)
        session_data = session

        parameter = {
          _nonce: session_data[:nonce],
          itemId: item_id,
          tags:   tags.join(',')
        }

        @requester.api_post('/tags/add', parameter)
        nil
      end

      def comment(item_id, comment, partent_id)
        session_data = session

        parameter = {
          _nonce:   session_data[:nonce],
          itemId:   item_id,
          parentId: partent_id,
          comment:  comment
        }

        @requester.api_post('/comments/post', parameter)
        nil
      end

      private

      def check_file_size(file)
        file_size_mb = File.size(file).to_f / 2**20

        return if file_size_mb <= 4.0
        return if session_data[:paid] && file_size_mb <= 8.0

        fail "File '#{file}' is to big: #{file_size_mb} MB."
      end

      def check_mime_type(file)
        mime = MIME::Types.type_for file

        fail "Unknown mime type for file '#{file}'." if mime.empty?

        valid = false
        mime.each do |detected|
          next unless ALLOWED_UPLOAD_TYPES.include?(detected.content_type)
          valid = true
          break
        end

        return if valid

        fail "Invalid mime type '#{mime_type}' for file '#{file}'."
      end

      def build_parameter(flag, tags, check_similar, file)
        session_data = session

        flag_state = flag.to_s
        tags.push(flag_state) if flag_state != 'sfw'

        parameter = {
          _nonce:       session_data[:nonce],
          tags:         tags.join(','),
          sfwstatus:    flag_state,
          checkSimilar: check_similar ? 1 : 0
        }

        process_file(file, parameter)
      end

      def process_file(file, parameter)
        # URL
        if file =~ /\A#{URI.regexp(%w(http https))}\z/
          parameter[:imageUrl] = file
        else
          parameter[:key] = upload_key(file)
        end

        parameter
      end

      def upload_key(file)
        check_mime_type(file)
        check_file_size(file)

        # TODO: resoultion, megapixel, duration

        file_handle = File.new(file, 'rb')

        result = @requester.api_post('/items/upload', image: file_handle)

        result['key']
      end
    end
  end
end
