require 'rest-client'
require 'uri'

require 'pr0gramm/requester/api'
require 'pr0gramm/requester/content'

class Pr0gramm

  class Requester

    attr_reader :session, :response, :images_url, :fullsize_url, :thumbs_url

    include Pr0gramm::Requester::API
    include Pr0gramm::Requester::Content

    def initialize(options)

      options = {
        host:           'pr0gramm.com',
        api_path:       '/api',
        protocol:       'https',
        use_subdomains: true,
      }.merge(options)

      @protocol = options[:protocol]
      @host     = options[:host]
      @base_url = "#{@protocol}://#{@host}"
      @api_url  = "#{@base_url}#{options[:api_path]}"
      @session  = nil

      if options[:use_subdomains]
        @images_url   = "#{@protocol}://img.#{@host}/"
        @fullsize_url = "#{@protocol}://full.#{@host}/"
        @thumbs_url   = "#{@protocol}://thumb.#{@host}/"
      else
        @images_url   = "#{@base_url}/data/images/"
        @fullsize_url = "#{@base_url}/data/fullsize/"
        @thumbs_url   = "#{@base_url}/data/thumbs/"
      end

      return if !options[:username] || !options[:password]

      login(options[:username], options[:password])
    end

    def inspect

      instance_vars = []
      instance_variables.map { |var|

        next if var.to_s == '@response'

        val = instance_variable_get(var)
        instance_vars.push( "#{var}=#{val || 'nil'}" )
      }

      "Pr0gramm::Requester:#{"0x00%x" % (object_id << 1)}) "+ instance_vars.join(', ')
    end
  end
end