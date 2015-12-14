module Api
  class MoviesController < ApplicationController

    skip_before_action :require_login, only: [:update, :update_movie_information]
    before_filter :find_movie, except: [:index]

    def index
      movies = logged_in? ? Movie.all : Movie.with_information
      render json: movies.map{ |m| MoviePartialSerializer.new(m).serializable_hash }
    end

    def update
      if @movie.update_attributes!(movie_params)
        render_movie
      end
    end

    def show
      render_movie
    end

    def update_movie_information
      if @movie.load_information(true)
        render_movie
      else
        head 404
      end
    end

    private

    def find_movie
      unless @movie = Movie.where(id: params[:id]).first
        head 404 and return false
      end
    end

    def render_movie
      render json: MovieSerializer.new(@movie)
    end

    def movie_params
      ps = params.require(:movie).permit(
          {:title_alternatives => []},
          {:stores => []},
          {:genres => []},
          :title_alternatives,
          :title,
          :available_since,
          :country,
          :year,
          :description,
        )

      # handle: Value for params[:movie][:foo] was set to nil, because it was one of [], [null] or [null, null, ...]
      %w(genres languages stores title_alternatives).each do |attr|
        ps[attr] = [] if ps.has_key?(attr.to_sym) && ps[attr].nil?
      end

      ps
    end
  end
end
