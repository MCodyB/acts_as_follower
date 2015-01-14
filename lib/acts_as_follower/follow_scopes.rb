module ActsAsFollower #:nodoc:
  module FollowScopes

    def for_follower(follower)
      where(:follower_id => follower.id,
            :follower_type => parent_class_name(follower))
    end

    def for_followable(followable)
      where(:followable_id => followable.id, :followable_type => parent_class_name(followable))
    end

    def for_follower_type(follower_type)
      where(:follower_type => follower_type)
    end

    def for_followable_type(followable_type)
      where(:followable_type => followable_type)
    end

    def recent(from)
      where(["created_at > ?", (from || 2.weeks.ago).to_s(:db)])
    end

    def descending
      order("follows.created_at DESC")
    end

    def unblocked
      where(status: [0, 1])
    end

    def blocked
      where(status: 3)
    end

    def pending
      where(status: 2)
    end

    def full
      where(status: 0)
    end

    def limited
      where(status: 1)
    end
  end
end
