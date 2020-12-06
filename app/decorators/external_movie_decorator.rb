# frozen_string_literal: true

class ExternalMovieDecorator
  REQUIRED_ATTRIBUTES = %w[rating plot poster].freeze

  def initialize(movie_hash)
    @movie_hash = movie_hash
  end

  def decorate
    movie_hash.slice(*REQUIRED_ATTRIBUTES).tap do |m|
      m['poster'] = "#{Movies::ExternalData::HOST}#{m['poster']}" if m['poster'].present?
    end
  end

  private

  attr_reader :movie_hash
end
