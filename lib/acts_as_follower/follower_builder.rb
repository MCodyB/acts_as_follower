module ActsAsFollower
  module FollowerBuilder
    def build_follower(followable)
      if self != followable
        self.follows.find_or_create_by({
            followable_id: followable.id,
            followable_type: parent_class_name(followable),
            status: followable.attributes[permission_default] || "good"
        })
      end
    end

    def permission_default
      :follow_default
    end
  end
end