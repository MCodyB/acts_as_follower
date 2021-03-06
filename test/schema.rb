ActiveRecord::Schema.define :version => 0 do

  create_table :follows, :force => true do |t|
    t.integer  "followable_id",   :null => false
    t.string   "followable_type", :null => false
    t.integer  "follower_id",     :null => false
    t.string   "follower_type",   :null => false
    t.integer  "status",          :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table :users, :force => true do |t|
    t.column :name,           :string
    t.column :follow_default, :integer, :default => 0
  end

  create_table :bands, :force => true do |t|
    t.column :name, :string
  end

end
