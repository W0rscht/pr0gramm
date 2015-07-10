require 'pr0gramm/api'
require 'pr0gramm/badge'
require 'pr0gramm/comment'
require 'pr0gramm/flags'
require 'pr0gramm/item'
require 'pr0gramm/mark'
require 'pr0gramm/message'
require 'pr0gramm/profile'
require 'pr0gramm/requester'
require 'pr0gramm/tag'
require 'pr0gramm/user'

class Pr0gramm

  attr_accessor :flags, :promoted
  attr_reader :requester

  include Pr0gramm::API

  def initialize(options = {})

    options = {
      flags:    [:sfw],
      promoted: true,
    }.merge(options)

    @promoted   = options[:promoted] # 'beliebt'
    @flags      = options[:flags]
    @last_flags = []

    @requester = Pr0gramm::Requester.new( options )

    # TODO
    # session = session
    # @flags  = session[:flags]
  end
end