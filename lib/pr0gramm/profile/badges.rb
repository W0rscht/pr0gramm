require 'time_difference'

class Pr0gramm
  class Profile
    module Badges
      BADGES = {
        comments: {
          template: {
            'image'       => 'comments.png',
            'link'        => '#user/%s/comments/before/%d',
            'description' => 'Hat mehr als %s Kommentare verfasst'
          },
          counts: [
            {
              count: 10_000,
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
            'description' => 'Hat %d %s auf pr0gramm verschwendet'
          }
        }
      }

      def to_badges(profile_data)
        @badges = []
        profile_data['badges'].each do |badge|
          @badges.push(Pr0gramm::Badge.new(@api, badge))
        end

        comments(profile_data['comments'].first)
        calc_registered
      end

      def comments(first_comment)
        BADGES[:comments][:counts].each do |level|
          next if level[:count] > @comment_count

          badge = comments_from_template(first_comment, level)

          @badges.push(Pr0gramm::Badge.new(@api, badge))

          break
        end
      end

      def comments_from_template(first_comment, level)
        badge = BADGES[:comments][:template]

        newest_comment_time = first_comment['created'].to_i + 1

        badge['link']        = format(badge['link'], @name, newest_comment_time)
        badge['description'] = format(badge['description'], level[:name])

        {
          'created' => newest_comment_time
        }.merge(badge)
      end

      def calc_registered
        difference       = TimeDifference.between(@registered, Time.now)
        since_registered = difference.in_years.to_i

        return unless since_registered >= 1

        year_s = 'Jahr'
        year_s += 'e' if since_registered > 1

        badge = registered_from_template(since_registered, year_s)

        @badges.push(Pr0gramm::Badge.new(@api, badge))
      end

      def registered_from_template(since, year_s)
        badge = BADGES[:years][:template]

        badge['link']        = format(badge['link'], @name)
        badge['description'] = format(badge['description'], since, year_s)

        {
          'created' => Time.now.to_i
        }.merge(badge)
      end
    end
  end
end
