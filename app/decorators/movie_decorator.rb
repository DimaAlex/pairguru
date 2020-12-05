# frozen_string_literal: true

class MovieDecorator < Draper::Decorator
  COVER_EXAMPLES = %w[abstract nightlife transport].freeze

  delegate_all

  def cover
    external_data['poster'] || "http://lorempixel.com/100/150/#{COVER_EXAMPLES.sample}?a=#{SecureRandom.uuid}"
  end

  def rating
    external_data['rating']
  end

  def plot
    external_data['plot']
  end
end
