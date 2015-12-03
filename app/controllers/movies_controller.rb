class MoviesController < ApplicationController

  def index
  end

  def show
    @movie = Movie.find(params[:id])
    render layout: false
  end
end
