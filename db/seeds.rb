# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Author.destroy_all
Tag.destroy_all
Ingredient.destroy_all

if Rails.env=='test'
  puts 'Seeding Test....'
  RecipesParser.execute('spec/mocks/recipes_mock.json')
else
  puts 'Seeding....'
  RecipesParser.execute 
end
