class Follow < ActiveRecord::Base
  # breaks tests
  enum status: %w(good limited pending blocked) #<%= statuses %>

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true

  # looks bad but need to move on
  def self.follower_nums
    @@follow_nums ||= self.statuses.dup.delete_if do |status, _|
      case status
      when "blocked", "pending"
        true
      else
        false
      end
    end.values
  end


  def block!
    self.update_attribute(:status, "blocked")
  end

  def confirm(probably_current_user)
    assign(probably_current_user, "good")
  end

  def assign(probably_current_user, confirm_val)
    if self.followable == probably_current_user
      self.update_attribute(:status, confirm_val)
    end
  end
end