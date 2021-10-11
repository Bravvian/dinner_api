require "activerecord-import"

class RecipesParser

  class << self
    def execute(file='recipes.json')
      data = File.foreach(file).map{|raw_line| JSON.parse(raw_line)}

      bulk_import_handler(data, 'author', Author)
      bulk_import_handler(data, 'tags', Tag)
      bulk_import_handler(data, 'ingredients', Ingredient)
      
      puts 'Creating recipes, this may take a few minutes....'
      File.foreach(file) do |line|
        #TODO: Change logic to import faster than this...
        create_record(JSON.parse(line))
      end
    end
    
    
    def bulk_import_handler(data, key, model)
      puts("Creating #{model}...")
      array = []
      values = data.map{|line| line[key]}.flatten.uniq

      values.each { |value| array << model.new(name: value)}

      model.import array
      
      puts "#{model}s created!!"
    end
    

    def create_record(line)
      
      recipe_data = line.except("ingredients", "author", "tags")

      author = Author.find_by(name: line["author"])
      
      recipe = Recipe.create(recipe_data.merge({author_id: author.id, name: line['name']}) )
      
      tags_array = []
      line["tags"].each do |tag|
        tag_record = Tag.find_by(name: tag)

        tags_array << RecipeTag.new(tag_id: tag_record.id, recipe: recipe )
      end
      
      RecipeTag.import tags_array

      ingredients_array = []
      line["ingredients"].each do |ingredient|
        ingredient_record = Ingredient.find_by(name: ingredient)
        #TODO: Parse ingredient to split name and quantity
        ingredients_array << RecipeIngredient.new(ingredient_id: ingredient_record.id, recipe: recipe, quantity: '', description: '')
      end

      RecipeIngredient.import ingredients_array

    end

    def parse_ingredient(ingredient) ;end
  end
end
