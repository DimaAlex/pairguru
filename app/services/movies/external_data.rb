# frozen_string_literal: true

require 'net/http'

module Movies
  class ExternalData
    HOST = 'https://pairguru-api.herokuapp.com'
    API_URL = '/api/v1/movies'
    SUCCESS_HTTP_CODE = '200'

    def initialize(title)
      @title = title
    end

    def fetch
      unless request.code == SUCCESS_HTTP_CODE
        Rails.logger.error("[PAIRGURU API] Fetching data for movie #{title} is failed with message #{parsed_error_body}")
        return {}
      end

      ExternalMovieDecorator.new(parsed_body).decorate
    end

    private

    attr_reader :title

    def request
      @request ||=
        Rails.cache.fetch("external_movies_data/#{title}", expires_in: 12.hours) do
          Net::HTTP.get_response(uri)
        end
    end

    def parsed_body
      JSON.parse(request.body)['data']['attributes']
    end

    def parsed_error_body
      JSON.parse(request.body)['message']
    end

    def uri
      URI("#{HOST}#{API_URL}/#{encoded_title}")
    end

    def encoded_title
      URI.encode(title)
    end
  end
end
