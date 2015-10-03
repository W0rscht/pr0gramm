require 'uri'

class Pr0gramm
  class Item
    module Paths
      def path(destination, fallback)
        uri = URI.parse(fallback)
        if destination.empty?
          File.basename(uri.path)
        elsif File.directory?(destination)
          "#{destination}/#{File.basename(uri.path)}"
        else
          destination
        end
      end

      def to_item_paths(item_data)
        to_image_path(item_data)
        to_thumb_path(item_data)
        to_fullsize_path(item_data)
      end

      def to_image_path(item_data)
        return if item_data['image'].empty?
        @image_path = item_data['image']
        @image_url  = "#{@api.requester.images_url}#{@image_path}"
      end

      def to_thumb_path(item_data)
        return if item_data['thumb'].empty?
        @thumb_path = item_data['thumb']
        @thumb_url  = "#{@api.requester.thumbs_url}#{@thumb_path}"
      end

      def to_fullsize_path(item_data)
        return if item_data['fullsize'].empty?
        @fullsize_path = item_data['fullsize']
        @fullsize_url  = "#{@api.requester.fullsize_url}#{@fullsize_path}"
      end
    end
  end
end
