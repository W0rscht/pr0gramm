require 'pr0gramm/item/paths'

class Pr0gramm
  class Item
    include Pr0gramm::Item::Paths

    attr_reader :id, :promoted, :votes_up, :votes_down, :created, :image_url,
                :thumb_url, :fullsize_url, :source, :flags, :user, :mark

    def initialize(api, item_data)
      @api = api

      to_instance_vars(item_data)
      to_item_paths(item_data)
    end

    def image
      return unless @image_path
      @api.requester.image(@image_path)
    end

    def save_image(destination = '')
      destination = path(destination, @image_path)

      File.open(destination, 'wb') do |output|
        output.write image
      end
    end

    def thumb
      return unless @thumb_path
      @api.requester.thumb(@thumb_path)
    end

    def save_thumb(destination = '')
      destination = path(destination, @thumb_path)

      File.open(destination, 'wb') do |output|
        output.write thumb
      end
    end

    def fullsize
      return unless @fullsize_path
      @api.requester.fullsize(@fullsize_path)
    end

    def save_fullsize(destination = '')
      destination = path(destination, @fullsize_path)

      File.open(destination, 'wb') do |output|
        output.write fullsize
      end
    end

    def vote(vote)
      @api.vote('item', @id, vote)
    end

    def fav
      vote(2)
    end

    def unfav
      up
    end

    def up
      vote(1)
    end

    def down
      vote(-1)
    end

    def comment(comment)
      @api.comment(@id, comment)
    end

    def tag(tags)
      @api.tag(@id, tags)
    end

    private

    def to_instance_vars(item_data)
      item_data = prepare_instance_vars(item_data)

      @id         = item_data['id']
      @promoted   = item_data['promoted']
      @votes_up   = item_data['up']
      @votes_down = item_data['down']
      @created    = item_data['created']
      @flags      = item_data['flags']
      @user       = item_data['user'] # TODO
      @mark       = item_data['mark']
      @source     = item_data['source']
    end

    def prepare_instance_vars(item_data)
      created_unix = item_data['created'].to_i
      source       = item_data['source'].empty? ? nil : item_data['source']

      item_data.merge('created' => Time.at(created_unix).to_datetime,
                      'flags'   => Pr0gramm::Flags.symbol(item_data['flags']),
                      'mark'    => Pr0gramm::Mark.string(item_data['mark']),
                      'source'  => source)
    end
  end
end
