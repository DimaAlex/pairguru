# frozen_string_literal: true

module Api
  module V1
    class MoviesController < BaseController
      def index
        json_response Movie.all
      end

      def show
        json_response movie
      end

      private

      def movie
        @movie ||= Movie.find(params[:id])
      end
    end
  end
end
