require 'pr0gramm/comment'
require 'pr0gramm/flags'
require 'pr0gramm/item'
require 'pr0gramm/requester'
require 'pr0gramm/user'

class Pr0gramm

  attr_accessor :flags
  attr_reader :items, :requester

  def initialize(options = {})

    options = {
      flags:    [:sfw],
      promoted: true,
    }.merge(options)

    @promoted   = options[:promoted] # 'beliebt'
    @flags      = options[:flags]
    @last_flags = []

    @requester = Pr0gramm::Requester.new( options )

    session = @requester.session

    return if !session

    # TODO
    # @flags = session[:flags]
  end

  def user(name)

    result = requester.get('/profile/info', { name: name, flags: @flags } )
    user   = Pr0gramm::User.new( result )

    user
  end

end