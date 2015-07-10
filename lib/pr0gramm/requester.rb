require 'rest-client'
require 'uri'

require 'pr0gramm/requester/api'
require 'pr0gramm/requester/content'

class Pr0gramm

  class Requester

    attr_reader :session, :response

    include Pr0gramm::Requester::API
    include Pr0gramm::Requester::Content

    def initialize(options)

      options = {
        url:      'pr0gramm.com',
        api_path: '/api',
        protocol: 'https',
      }.merge(options)

      @protocol = options[:protocol]
      @url      = options[:url]
      @base_url = "#{@protocol}://#{@url}"
      @api_url  = "#{@base_url}#{options[:api_path]}"
      @session  = nil

      return if !options[:username] || !options[:password]

      login(options[:username], options[:password])
    end
  end
end