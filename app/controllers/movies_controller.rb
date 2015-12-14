class MoviesController < ApplicationController

  skip_before_action :require_login, only: [:edit]

  def index
  end

  def show
    @movie = Movie.find(params[:id])
    render layout: false
  end

  def edit
    @movie = Movie.find(params[:id])
    render layout: false
  end
end
