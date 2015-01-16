class User < ActiveRecord::Base
  enum status: %w(good limited pending blocked)

  validates_presence_of :name

  acts_as_follower
  acts_as_followable
end
