class AddStickyToTopic < ActiveRecord::Migration
  def self.up
      add_column :topics, :sticky, :integer, :default => 0
  end

  def self.down
      remove_column :topics, :sticky
  end
end
