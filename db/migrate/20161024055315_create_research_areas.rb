class CreateResearchAreas < ActiveRecord::Migration
  def change
    create_table :research_areas do |t|
      t.string :uri
      t.timestamps null: false
    end

    add_index :research_areas, %i(uri), unique: true, name: 'research_areas_dimensions'
  end
end
