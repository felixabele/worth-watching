class MovieSerializer < ActiveModel::MongoidSerializer
  attributes :id, :title_alternatives, :title, :available_since, :genres, :country, :year, :description, :stores


end
