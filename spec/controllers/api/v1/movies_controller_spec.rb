# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  let!(:movie) { create(:movie) }
  let(:apikey) { 'api_key_test' }
  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:expected_response_body) do
    [{
      id: movie.id,
      title: movie.title
    }]
  end

  it_behaves_like 'authenticable', :index

  describe 'GET /api/v1/movies' do
    context 'when request is successful' do
      let(:expected_response_body) do
        [{
          id: movie.id,
          title: movie.title
        }]
      end

      before { request.headers['apikey'] = apikey }

      it 'returns correct response' do
        get :index, format: :json
        expect(json_response).to eq(expected_response_body)
      end
    end
  end

  describe 'GET /api/v1/movies/:id' do
    before { request.headers['apikey'] = apikey }

    it 'returns correct response' do
      get :show, params: { id: movie.id, format: :json }
      expect(json_response).to eq(expected_response_body.first)
    end
  end
end
