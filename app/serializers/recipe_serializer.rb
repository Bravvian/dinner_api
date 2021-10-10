# frozen_string_literal: true

class RecipeSerializer < ActiveModel::Serializer
  attr_reader :record
  def initialize(record)
    @record = record
  end

  def serialize
    {
      name: record.name,
      cook_time: record.cook_time,
      people_quantity: record.people_quantity,
      author: record.author.name,
      tags: record.tags.map{|t| t.name},
      ingredients: record.ingredients.map{|t| t.name}
    }
  end
end
