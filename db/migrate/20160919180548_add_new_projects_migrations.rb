class AddNewProjectsMigrations < ActiveRecord::Migration
  def change
    rename_column :projects, :description, :full_description

    add_column :projects, :short_description, :text, limit: 500, null: true, default: nil
  end
end
