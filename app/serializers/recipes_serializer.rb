# frozen_string_literal: true

class RecipesSerializer < ActiveModel::Serializer
  attr_reader :collection
  
  def initialize(collection)
    @collection = collection
  end

  def serialize
    collection.map do |record|
      {
        id: record.id,
        image: record.image,
        rate: record.rate,
        name: record.name
      }
    end
  end
end
