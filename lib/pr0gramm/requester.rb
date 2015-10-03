require 'rest-client'
require 'uri'

require 'pr0gramm/requester/api'
require 'pr0gramm/requester/content'

class Pr0gramm
  class Requester
    attr_reader :session, :response, :images_url, :fullsize_url, :thumbs_url,
                :badges_url, :username, :password

    include Pr0gramm::Requester::API
    include Pr0gramm::Requester::Content

    def initialize(options)
      options = {
        host:           'pr0gramm.com',
        api_path:       '/api',
        protocol:       'https',
        use_subdomains: true
      }.merge(options)

      @protocol = options[:protocol]
      @host     = options[:host]

      urls(options)

      credentials(options[:username], options[:password])
    end

    def inspect
      instance_vars = []
      instance_variables.map do |var|
        next if var.to_s == '@response'
        next if var.to_s == '@password'

        val = instance_variable_get(var)
        instance_vars.push("#{var}=#{val || 'nil'}")
      end

      object_number = format('0x00%x', object_id << 1)
      "Pr0gramm::Requester:#{object_number} " + instance_vars.join(', ')
    end

    private

    def urls(options)
      @base_url   = "#{@protocol}://#{@host}"
      @api_url    = "#{@base_url}#{options[:api_path]}"
      @badges_url = "#{@base_url}/media/badges/"

      item_urls(options[:use_subdomains])
    end

    def item_urls(use_subdomains)
      if use_subdomains
        @images_url   = "#{@protocol}://img.#{@host}/"
        @fullsize_url = "#{@protocol}://full.#{@host}/"
        @thumbs_url   = "#{@protocol}://thumb.#{@host}/"
      else
        @images_url   = "#{@base_url}/data/images/"
        @fullsize_url = "#{@base_url}/data/fullsize/"
        @thumbs_url   = "#{@base_url}/data/thumbs/"
      end
    end

    def credentials(username, password)
      return if !username || !password

      @username = username
      @password = password

      login(username, password)
    end
  end
end
