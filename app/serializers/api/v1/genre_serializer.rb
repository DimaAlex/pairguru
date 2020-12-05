# frozen_string_literal: true

class Api::V1::GenreSerializer < ActiveModel::Serializer
  attributes :id, :name, :movie_count

  def movie_count
    object.movies.count
  end
end
