class CreateColloquia < ActiveRecord::Migration[5.0]
  def change
    create_table :colloquia do |t|
      t.string :title
      t.text :body
      t.datetime :day
      t.timestamps
    end
  end
end
