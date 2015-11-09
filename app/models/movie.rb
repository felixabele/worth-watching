class Movie

  include Mongoid::Document

  field :available_since, type: Date
  field :country, type: String
  field :description, type: String
  field :genres, type: Array
  field :languages, type: Array
  field :stores, type: Array
  field :title, type: String
  field :year, type: Integer

  index title: 1
end
