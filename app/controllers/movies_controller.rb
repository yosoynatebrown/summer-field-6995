class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    actor = Actor.find_by(name: params[:name])
    if actor.nil?
      redirect_to "/movies/#{@movie.id}"
    else
      @movie.actors << actor
      redirect_to "/movies/#{@movie.id}"
    end
  end
end
