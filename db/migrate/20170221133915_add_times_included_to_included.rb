class AddTimesIncludedToIncluded < ActiveRecord::Migration
  def change
    add_column :includeds, :times_included, :integer, default: 0
    add_column :includeds, :times_excluded, :integer, default: 0
  end
end
