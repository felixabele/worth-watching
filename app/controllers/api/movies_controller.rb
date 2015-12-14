module Api
  class MoviesController < ApplicationController

    skip_before_action :require_login, only: [:update]

    def index
      render json: Movie.with_information.map{ |m| MoviePartialSerializer.new(m).serializable_hash }
    end

    def update
      movie = Movie.find(params[:id])
      puts movie_params
      if movie.update_attributes(movie_params)
        render json: MovieSerializer.new(movie)
      else
        head 404
      end
    end

    private

    def movie_params
      params.require(:movie).permit(
          {:title_alternatives => []},
          {:stores => []},
          {:genres => []},
          :title,
          :available_since,
          :country,
          :year,
          :description,
        )
    end
  end
end
