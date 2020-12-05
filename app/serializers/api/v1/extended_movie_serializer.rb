# frozen_string_literal: true

module Api
  module V1
    class ExtendedMovieSerializer < MovieSerializer
      belongs_to :genre
    end
  end
end
