# frozen_string_literal: true

module Api
  module V1
    class ExtendedMoviesController < BaseController
      def index
        render json: Movie.includes(:genre).all,
               each_serializer: ::Api::V1::ExtendedMovieSerializer,
               status: :ok
      end

      def show
        render json: movie, serializer: ::Api::V1::ExtendedMovieSerializer, status: :ok
      end

      private

      def movie
        @movie ||= Movie.includes(:genre).find(params[:id])
      end
    end
  end
end
