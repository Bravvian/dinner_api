class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :rate
      t.string :author_tip
      t.string :budget
      t.string :prep_time
      t.string :difficulty
      t.integer :people_quantity
      t.string :cook_time
      t.string :total_time
      t.string :image
      t.string :nb_comments

      t.references :author, foreign_key: true


      t.timestamps
    end
  end
end

