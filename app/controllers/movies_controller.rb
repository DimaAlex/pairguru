class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = ExternalMovieDecorator.decorate_collection(Movie.all)
  end

  def show
    @movie = ExternalMovieDecorator.decorate(movie)
  end

  def send_info
    MovieInfoMailer.send_info(current_user, movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  private

  def movie
    @movie ||= Movie.find(params[:id])
  end
end
