module Api
  class MoviesController < ApplicationController

    def index
      render json: Movie.with_information.all
    end
  end
end
