# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::ExternalData, type: :service do
  RSpec.shared_examples 'fetches data' do
    it { is_expected.to eq expected_response }
  end

  describe '#fetch' do
    subject { described_class.new(title).fetch }

    let(:title) { 'Deadpool' }
    let(:status) { 200 }

    before do
      stub_request(:get, URI("https://pairguru-api.herokuapp.com/api/v1/movies/#{title}"))
        .to_return(status: status, body: expected_body)
    end

    context 'when request code is successful' do
      let(:expected_response) do
        {
          'plot' => 'A fast-talking mercenary with a morbid sense of humor is subjected.',
          'rating' => 8.0,
          'poster' => 'https://pairguru-api.herokuapp.com/deadpool.jpg'
        }
      end
      let(:expected_body) do
        {
          data: {
            id: '10',
            type: 'movi',
            attributes: {
              title: 'Deadpool',
              plot: 'A fast-talking mercenary with a morbid sense of humor is subjected.',
              rating: 8.0,
              poster: '/deadpool.jpg'
            }
          }
        }.to_json
      end

      it_behaves_like 'fetches data'
    end

    context 'when request code is not 200' do
      let(:status) { 404 }
      let(:expected_body) { { message: "Couldn't find Movie" }.to_json }
      let(:expected_response) { {} }

      it_behaves_like 'fetches data'
    end
  end
end
