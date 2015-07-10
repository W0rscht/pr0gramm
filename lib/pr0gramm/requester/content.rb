require 'uri'
require 'net/http'

class Pr0gramm
  class Requester
    module Content

      def image(file_path)
        content( "#{@images_url}#{file_path}" )
      end

      def fullsize(file_path)
        content( "#{@fullsize_url}#{file_path}" )
      end

      def thumb(file_path)
        content( "#{@thumbs_url}#{file_path}" )
      end

      def content(url)

        uri  = URI.parse( url )
        host = uri.host

        content = nil
        Net::HTTP.start( uri.host ) do |http|
          resp    = http.get( uri.path )
          content = resp.body
        end

        content
      end

    end
  end
end