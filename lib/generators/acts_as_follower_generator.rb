require 'rails/generators'
require 'rails/generators/migration'

class ActsAsFollowerGenerator < Rails::Generators::Base

  include Rails::Generators::Migration

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  #takes an array of optional cli options
  # for enum in the model template of the form
  # $ rails g acts_as_follower --statuses foo bar bat buzz
  # if nothing provided reverts to default. Pending should be
  # able to be ignored if that functionality isn't desired
  class_option :statuses, type: :array, default: %w(good limited pending blocked)

  # Implement the required interface for Rails::Generators::Migration.
  # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
     "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/acts_as_follower_migration.rb'
  end

  def create_model
    template "model.rb", File.join('app/models', "follow.rb")
  end

  private
  def statuses
    options["statuses"]
  end
end
