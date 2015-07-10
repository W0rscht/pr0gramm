require 'time_difference'

class Pr0gramm

  class Profile

    BADGES = {
      comments: {
        template: {
            'image'       => 'comments.png',
            'link'        => '#user/%s/comments/before/%d',
            'description' => 'Hat mehr als %s Kommentare verfasst',
        },
        counts: [
            {
                count: 10000,
                name: '10k'
            },
            {
                count: 5000,
                name: '5k'
            },
            {
                count: 1000,
                name: '1k'
            }
        ]
    },
    years: {
        template: {
            'image'       => 'years.png',
            'link'        => '#user/%s',
            'description' => 'Hat %d %s auf pr0gramm verschwendet',
        },
    }

    }

    attr_reader :id, :name, :registered, :score, :mark, :admin, :banned,
                :comment_count, :upload_count, :like_count, :tag_count,
                :follow_count, :likes_are_public, :following, :badges

    def initialize(api, profile_data)

      @api = api

      @id         = profile_data['user']['id']
      @name       = profile_data['user']['name']
      @registered = Time.at( profile_data['user']['registered'].to_i ).to_datetime
      @score      = profile_data['user']['score']
      @mark       = Pr0gramm::Mark.string( profile_data['user']['mark'] )
      @admin      = profile_data['user']['admin'] == 1 ? true : false
      @banned     = profile_data['user']['banned'] == 1 ? true : false

      @comment_count    = profile_data['commentCount']
      @upload_count     = profile_data['uploadCount']
      @like_count       = profile_data['likeCount']
      @tag_count        = profile_data['tagCount']
      @follow_count     = profile_data['followCount']
      @likes_are_public = profile_data['likesArePublic']
      @following        = profile_data['following']

      @badges = []
      profile_data['badges'].each { |badge|
        @badges.push( Pr0gramm::Badge.new( @api, badge ) )
      }

      BADGES[:comments][:counts].each { |level|

        next if level[:count] > @comment_count

        badge = BADGES[:comments][:template]

        newest_comment_time  = profile_data['comments'].first['created'].to_i + 1
        badge['link']        = badge['link'] % [ @name, newest_comment_time ]
        badge['description'] = badge['description'] % [ level[:name] ]

        badge = {
          'created' => newest_comment_time,
        }.merge(badge)

        @badges.push( Pr0gramm::Badge.new( @api, badge ) )

        break
      }

      since_registerd = TimeDifference.between(@registered, Time.now).in_years.to_i
      if since_registerd >= 1

        year_s = 'Jahr'
        if since_registerd > 1
          year_s += 'e'
        end

        badge = BADGES[:years][:template]

        badge['link']        = badge['link'] % [ @name ]
        badge['description'] = badge['description'] % [ since_registerd, year_s ]

        badge = {
          'created' => Time.now.to_i,
        }.merge(badge)

        @badges.push( Pr0gramm::Badge.new( @api, badge ) )

      end

      # TODO:
      # - comments
      # - uploads
      # - likes
      # - following
    end
  end

end
