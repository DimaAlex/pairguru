# frozen_string_literal: true

RSpec.shared_context 'with apikey' do
  let(:apikey) { 'api_key_test' }

  before { request.headers['apikey'] = apikey }
end
