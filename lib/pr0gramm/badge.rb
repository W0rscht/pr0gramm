class Pr0gramm

  class Badge

    attr_reader :link, :image, :description, :created

    def initialize(api, badge_data)

      @api = api

      @link        = badge_data['link'].gsub(/\#/, '/')
      @image_path  = badge_data['image']
      @image_url   = "#{@api.requester.badges_url}#{@image_path}"
      @description = badge_data['description']
      @created     = Time.at( badge_data['created'].to_i ).to_datetime
    end

    def image
      @api.requester.content( @image_url )
    end
  end
end
