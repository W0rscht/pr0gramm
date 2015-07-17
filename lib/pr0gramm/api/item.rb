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

      def items( parameter = {} )

        parameter = {
          flags:    @flags,
          promoted: @promoted
        }.merge( parameter )

        # TODO: less hacky
        parameter[:promoted] = nil if !parameter[:promoted]

        result = @requester.api_get('/items/get', parameter)

        # TODO:
        # result['atEnd']
        # result['atStart']
        # result['error']
        # result['ts']
        # result['rt']
        # result['cache']
        # result['qc']

        items = []
        result['items'].each { |item|
          items.push( Pr0gramm::Item.new( self, item ) )
        }

        items
      end

      def item_info(item_id)
        info = @requester.api_get('/items/info', { itemId: item_id })

        tags = []
        info['tags'].each { |tag|
          tags.push( Pr0gramm::Tag.new( self, tag ) )
        }

        comments = []
        info['comments'].each { |comment|
          comments.push( Pr0gramm::Comment.new( self, comment ) )
        }

        {
          comments: comments,
          tags:     tags
        }
      end

      def upload(file, flag, tags, check_similar = true)

        session_data = @requester.session

        fail 'Not logged in.' if !session_data

        flag_state = flag.to_s
        if flag_state != 'sfw'
          tags.push(flag_state)
        end

        parameter = {
          _nonce:       session_data[:nonce],
          tags:         tags.join(','),
          sfwstatus:    flag_state,
          checkSimilar: check_similar ? 1 : 0,
        }

        # URL
        if file =~ /\A#{URI::regexp(['http', 'https'])}\z/
          parameter[:imageUrl] = file
        else
          mime = MIME::Types.type_for file

          mime_type = 'unknown'
          if !mime.empty? && mime[0].content_type
            mime_type = mime[0].content_type
          end

          if !ALLOWED_UPLOAD_TYPES.include?( mime_type )
            fail "Invalid mime type '#{mime_type}' for file '#{file}'."
          end

          file_size_mb = File.size( file ).to_f / 2**20

          if file_size_mb > 4.0


            if !session_data[:paid] || file_size_mb > 8.0
              fail "File '#{file}' is to big: #{file_size_mb} MB."
            end
          end

          # TODO: resoultion, megapixel, duration

          result = @requester.api_post('/items/upload', { image: File.new(file, 'rb') })

          parameter[:key] = result['key']
        end

        result = @requester.api_post('/items/post', parameter)

        # TODO: Pr0gramm::Item.new?
        if result['similar']
          return result['similar']
        end

        if result['error']
          fail "Upload error: #{result['error']}."
        end

        # "{\"error\"=>nil, \"selfPosted\"=>true, \"item\"=>{\"id\"=>893147}, \"ts\"=>1436885732, \"cache\"=>nil, \"rt\"=>733, \"qc\"=>53}"
        return result['item']['id']
      end

      def vote( object, id, vote )

        session_data = @requester.session

        fail 'Not logged in.' if !session_data

        parameter = {
          _nonce: session_data[:nonce],
          id:     id,
          vote:   vote,
        }

        @requester.api_post("/#{object}s/vote", parameter)
        nil
      end

      def tag(item_id, tags)

        session_data = @requester.session

        fail 'Not logged in.' if !session_data

        parameter = {
          _nonce: session_data[:nonce],
          itemId: item_id,
          tags:   tags.join(','),
        }

        @requester.api_post('/tags/add', parameter)
        nil
      end
    end
  end
end