# frozen_string_literal: true

class ExternalMovieDecorator < MovieDecorator
  REQUIRED_ATTRIBUTES = %w[rating plot poster].freeze

  def cover
    poster || super
  end

  REQUIRED_ATTRIBUTES.each do |attr|
    define_method(attr) { external_data[attr] }
  end
end
