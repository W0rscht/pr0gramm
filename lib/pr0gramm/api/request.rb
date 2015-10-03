# TODO: refactor

class Pr0gramm
  module API
    module Request
      def items(parameter = {})
        parameter = {
          flags:    @flags,
          promoted: @promoted
        }.merge(parameter)

        # TODO: less hacky
        parameter.delete(:promoted) unless parameter[:promoted]
        parameter[:flags]    = Pr0gramm::Flags.digit(parameter[:flags])

        p parameter.inspect

        result = @requester.api_get('/items/get', parameter)

        # TODO: Remaining attributes
        # result['atEnd']
        # result['atStart']
        # result['error']
        # result['ts']
        # result['rt']
        # result['cache']
        # result['qc']

        items_from_result(result['items'])
      end

      def item_info(item_id)
        info = @requester.api_get('/items/info', itemId: item_id)

        {
          comments: comments_from_result(info['comments'], item_id),
          tags:     tags_from_result(info['tags'])
        }
      end

      private

      def items_from_result(list)
        items = []
        list.each do |item|
          items.push(Pr0gramm::Item.new(self, item))
        end

        items
      end

      def tags_from_result(list)
        tags = []
        list.each do |tag|
          tags.push(Pr0gramm::Tag.new(self, tag))
        end
        tags
      end

      def comments_from_result(list, item_id)
        comments = []
        list.each do |comment|
          comments.push(Pr0gramm::Comment.new(self, item_id, comment))
        end
        comments
      end
    end
  end
end
