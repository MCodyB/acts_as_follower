class Follow < ActiveRecord::Base
  # breaks tests
  enum status: %w(good limited pending blocked) #<%= statuses %>

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true

  def block!
    self.update_attribute(:status, 3)
  end

  def confirm(probably_current_user, confirm_val)
    if self.followable == probably_current_user
      self.status = confirm_val
      self.save
    end
  end
end
