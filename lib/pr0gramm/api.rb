class Pr0gramm

  module API

    def user(name = nil)

      if !name
        session_data = session
        fail 'Not logged in. Missing username to request.' if !session_data
        name = session_data[:name]
      end

      result = @requester.get('/profile/info', { name: name, flags: @flags })
      user   = Pr0gramm::User.new( result )

      user
    end

    def items( parameter = {} )

      parameter = {
        flags:    @flags,
        promoted: @promoted
      }.merge( parameter )


      result = @requester.get('/items/get', parameter)

      # TODO:
      # result['atEnd']
      # result['atStart']
      # result['error']
      # result['ts']
      # result['rt']
      # result['cache']
      # result['qc']

      items = []
      result['items'].each{ |item|
        items.push( Pr0gramm::Item.new( item ) )
      }

      items
    end

    def item_info(item_id)
      info = @requester.get('/items/info', { itemId: item_id })

      tags = []
      info['tags'].each { |tag|
        tags.push( Pr0gramm::Tag.new( tag ) )
      }

      comments = []
      info['comments'].each { |comment|
        comments.push( Pr0gramm::Comment.new( comment ) )
      }

      {
        comments: comments,
        tags:     tags
      }
    end

    def session
      @requester.session
    end
  end
end