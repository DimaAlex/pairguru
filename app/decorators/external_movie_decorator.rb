# frozen_string_literal: true

class ExternalMovieDecorator
  REQUIRED_ATTRIBUTES = %w[rating plot poster].freeze

  def initialize(movie)
    @movie = movie
  end

  def decorate
    movie.slice(*REQUIRED_ATTRIBUTES).tap do |m|
      m['poster'] = "#{Movies::ExternalData::HOST}#{m['poster']}" if m['poster'].present?
    end
  end

  private

  attr_reader :movie
end
