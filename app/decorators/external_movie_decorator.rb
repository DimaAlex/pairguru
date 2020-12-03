# frozen_string_literal: true

class ExternalMovieDecorator
  REQUIRED_ATTRIBUTES = %w[rating plot].freeze

  def initialize(movie)
    @movie = movie
  end

  def decorate
    movie.slice(*REQUIRED_ATTRIBUTES).each do |name, value|
      set_attributes(name, value)
    end

    self
  end

  def poster
    "#{Movies::ExternalData::HOST}#{movie['poster']}"
  end

  private

  attr_reader :movie

  def set_attributes(name, value)
    instance_variable_set("@#{name}", value)
    self.class.instance_eval { attr_reader name }
  end
end
