class CreateCourseTags < ActiveRecord::Migration
  def change
    create_table :course_tags do |t|
      t.string :word
      t.references :course
      t.timestamps null: false
    end
  end
end
