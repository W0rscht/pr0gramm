class Pr0gramm

  module API

    def user(name)

      result = @requester.get('/profile/info', { name: name, flags: @flags })
      user   = Pr0gramm::User.new( result )

      user
    end

    def items()

      result = @requester.get('/items/get', { flags: @flags, promoted: @promoted })

      # TODO:
      # result['atEnd']
      # result['atStart']
      # result['error']
      # result['ts']
      # result['rt']
      # result['cache']
      # result['qc']

p result.inspect

      items = []
      result['items'].each{ |item|
        items.push( Pr0gramm::Item.new( item ) )
      }

      items
    end

  end
end