require 'pr0gramm/requester'

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
end