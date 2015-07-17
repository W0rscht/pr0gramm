require 'uri'

class Pr0gramm

  class Item

    attr_reader :id, :promoted, :votes_up, :votes_down, :created, :image_url,
                :thumb_url, :fullsize_url, :source, :flags, :user, :mark

    def initialize(api, item_data)

      @api = api

      @id         = item_data['id']
      @promoted   = item_data['promoted']
      @votes_up   = item_data['up']
      @votes_down = item_data['down']
      @created    = Time.at( item_data['created'].to_i ).to_datetime
      @flags      = Pr0gramm::Flags.symbol( item_data['flags'] )
      @user       = item_data['user'] # TODO
      @mark       = Pr0gramm::Mark.string( item_data['mark'] )

      if !item_data['source'].empty?
        @source = item_data['source']
      end

      if !item_data['image'].empty?
        @image_path = item_data['image']
        @image_url  = "#{api.requester.images_url}#{@image_path}"
      end

      if !item_data['thumb'].empty?
        @thumb_path = item_data['thumb']
        @thumb_url  = "#{api.requester.thumbs_url}#{@thumb_path}"
      end

      if !item_data['fullsize'].empty?
        @fullsize_path = item_data['fullsize']
        @fullsize_url  = "#{api.requester.fullsize_url}#{@fullsize_path}"
      end
    end

    def image
      return if !@image_path
      @api.requester.image( @image_path )
    end

    def save_image(destination='')

      destination = path( destination, @image_path )

      File.open(destination, 'wb') do |output|
        output.write image
      end
    end

    def thumb
      return if !@thumb_path
      @api.requester.thumb( @thumb_path )
    end

    def save_thumb(destination='')

      destination = path( destination, @thumb_path )

      File.open(destination, 'wb') do |output|
        output.write thumb
      end
    end

    def fullsize
      return if !@fullsize_path
      @api.requester.fullsize( @fullsize_path )
    end

    def save_fullsize(destination='')

      destination = path( destination, @fullsize_path )

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
      @api.taf(@id, tags)
    end

    private

    def path(destination, fallback)

      directory = ''
      filename  = ''
      if destination.empty?
        uri      = URI.parse( fallback )
        filename = File.basename(uri.path)
      elsif File.directory?(destination)
        directory = destination
        uri       = URI.parse( fallback )
        filename  = File.basename(uri.path)
      else
        directory = File.dirname( destination ) +'/'
        filename  = File.basename( destination )
      end

      "#{directory}#{filename}"
    end

  end
end
