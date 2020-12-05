# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ExtendedMoviesController, type: :controller do
  let!(:movie) { create(:movie) }
  let!(:genre) { movie.genre }
  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:expected_response_body) do
    [{
      id: movie.id,
      title: movie.title,
      genre: {
        id: genre.id,
        name: genre.name,
        movie_count: genre.movies.count
      }
    }]
  end

  describe 'GET /api/v1/extended_movies' do
    it_behaves_like 'authenticable', :index

    context 'when request is successful' do
      include_context 'with apikey'

      it 'returns correct response' do
        get :index, format: :json
        expect(json_response).to eq(expected_response_body)
      end
    end
  end

  describe 'GET /api/v1/extended_movies/:id' do
    include_context 'with apikey'

    it 'returns correct response' do
      get :show, params: { id: movie.id, format: :json }
      expect(json_response).to eq(expected_response_body.first)
    end
  end
end
