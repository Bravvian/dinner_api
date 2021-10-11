
module Api
  module V1
    class RecipesController < ApplicationController

      def index
        filtered_params = permitted_params
        ingredients = ingredients_array(filtered_params['ingredients'])
        recipes = if ingredients.empty? 
                    Recipe.first(rand(0..30))
                  else 
                    Recipe.includes(:recipe_ingredients => :ingredient).where(recipe_ingredients: {ingredients: {name: ingredients}}) 
                  end
        
        render status: :ok, json: RecipesSerializer.new(recipes).serialize
      end

      def show
        recipe = Recipe.find_by(id: params[:id])
        
        if recipe
          render status: :ok, json: RecipeSerializer.new(recipe).serialize
        else
          render status: :not_found, message: 'The recipe with that id does not exists'
        end
      end

      def create;end

      def update;end

      def destroy;end

      private

      def permitted_params
        params.permit(:ingredients)
      end
      
      def ingredients_array(ingredients)
        ingredients.split(',')
      end
    end
  end
end
