class Pr0gramm

  module API

    def profile(name = nil)

      if !name
        session_data = session
        fail 'Not logged in. Missing username to request.' if !session_data
        name = session_data[:name]
      end

      result  = @requester.api_get('/profile/info', { name: name, flags: Pr0gramm::Flags.integer( @flags ) })
      profile = Pr0gramm::Profile.new( self, result )

      profile
    end

    def user
      fail 'Not logged in.' if !session

      result = @requester.api_get('/user/info')
      Pr0gramm::User.new(self, result)
    end

    def items( parameter = {} )

      parameter = {
        flags:    @flags,
        promoted: @promoted
      }.merge( parameter )

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