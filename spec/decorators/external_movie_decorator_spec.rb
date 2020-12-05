# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalMovieDecorator do
  describe '#decorate' do
    subject { described_class.new(data).decorate }

    let(:data) do
      {
        'rating' => 8.0,
        'poster' => poster
      }
    end

    context 'when poster data exists' do
      let(:poster) { '/deadpool.jpg' }

      it 'changes poster' do
        expect(subject['poster']).to eq 'https://pairguru-api.herokuapp.com/deadpool.jpg'
      end
    end

    context 'when poster data does not exist' do
      let(:poster) { nil }

      it 'changes poster' do
        expect(subject['poster']).to be_nil
      end
    end
  end
end
