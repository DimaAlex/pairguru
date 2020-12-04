# frozen_string_literal: true

module Api::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from StandardError do |e|
      Rails.logger.error(e)
      json_response({ message: 'Unexpected error happened' }, :internal_server_error)
    end
  end
end
