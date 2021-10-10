class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.text :name

      t.timestamps
    end

    add_index :ingredients, :name, unique: true, length: 100
  end
end
