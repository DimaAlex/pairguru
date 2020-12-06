# frozen_string_literal: true

require 'net/http'

module Movies
  class ExternalData
    HOST = 'https://pairguru-api.herokuapp.com'
    API_URL = '/api/v1/movies'

    def initialize(title)
      @title = title
    end

    def fetch
      Rails.cache.fetch("external_movies_data/#{title}", expires_in: 12.hours) do
        handle_response
      end
    end

    private

    attr_reader :title

    def request
      @request ||= Net::HTTP.get_response(uri)
    end

    def parsed_body
      @parsed_body ||= JSON.parse(request.body)
    end

    def attributes
      parsed_body.dig('data', 'attributes')
    end

    def handle_response
      case request
      when Net::HTTPSuccess, Net::HTTPRedirection then
        ExternalMovieDecorator.new(attributes).decorate
      else
        Rails.logger.warn(error_message)
        {}
      end
    end

    def uri
      URI("#{HOST}#{API_URL}/#{encoded_title}")
    end

    def encoded_title
      URI.encode(title)
    end

    def error_message
      "[PAIRGURU API] Fetching data for movie #{title} is failed with message #{parsed_body['message']}"
    end
  end
end
