module Api
  class MoviesController < ApplicationController

    def index
      render json: Movie.with_information.map{ |m| MovieSerializer.new(m).serializable_hash }
    end
  end
end
