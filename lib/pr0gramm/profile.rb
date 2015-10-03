require 'time_difference'
require 'pr0gramm/profile/badges'

class Pr0gramm
  class Profile
    include Pr0gramm::Profile::Badges

    attr_reader :id, :name, :registered, :score, :mark, :admin, :banned,
                :comment_count, :upload_count, :like_count, :tag_count,
                :follow_count, :likes_are_public, :following, :badges

    def initialize(api, profile_data)
      @api = api

      to_instance_vars(profile_data)
      count_instance_vars(profile_data)
      to_badges(profile_data)

      # TODO: remaining attributes
      # - comments
      # - uploads
      # - likes
      # - following
    end

    private

    def to_instance_vars(profile_data)
      profile_data = prepare_instance_vars(profile_data)

      @id               = profile_data['id']
      @name             = profile_data['name']
      @registered       = profile_data['registered']
      @score            = profile_data['score']
      @mark             = profile_data['mark']
      @admin            = profile_data['admin']
      @banned           = profile_data['banned']
      @likes_are_public = profile_data['likesArePublic']
      @following        = profile_data['following']
    end

    def prepare_instance_vars(profile_data)
      profile_data = reduce_structure(profile_data)

      profile_data.merge(
        'registered' => Time.at(profile_data['registered']).to_datetime,
        'mark'       => Pr0gramm::Mark.string(profile_data['mark']),
        'admin'      => profile_data['admin'] == 1 ? true : false,
        'banned'     => profile_data['banned'] == 1 ? true : false
      )
    end

    def reduce_structure(profile_data)
      user_data = profile_data['user']

      profile_data.merge(
        'id'         => user_data['id'],
        'name'       => user_data['name'],
        'score'      => user_data['score'],
        'registered' => user_data['registered'].to_i,
        'mark'       => user_data['mark'],
        'admin'      => user_data['admin'],
        'banned'     => user_data['banned']
      )
    end

    def count_instance_vars(profile_data)
      @comment_count = profile_data['commentCount']
      @upload_count  = profile_data['uploadCount']
      @like_count    = profile_data['likeCount']
      @tag_count     = profile_data['tagCount']
      @follow_count  = profile_data['followCount']
    end
  end
end
