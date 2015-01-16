module ActsAsFollower
  module FollowerBuilder
    def build_follower(followable)
      if self != followable
        self.follows.find_or_create_by({
            :followable_id => followable.id,
            :followable_type => parent_class_name(followable),
            :status => get_status(followable)
        })
      end
    end

    private
    def get_status(followable)
      indiv_default(followable) || class_default(followable)
    end

    def class_default(followable)
      followable.set_follow_status_as
    end

    def indiv_default(followable)
      followable.attributes[permission_default]
    end

    def permission_default
      :follow_default
    end
  end
end