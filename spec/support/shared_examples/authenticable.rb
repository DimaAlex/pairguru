# frozen_string_literal: true

RSpec.shared_examples 'authenticable' do |end_point|
  it 'rejects request without token' do
    get end_point, format: :json

    expect(response.code).to eq '401'
  end
end
