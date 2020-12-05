# frozen_string_literal: true

class Api::V1::BaseController < ActionController::API
  include ::Api::Response
  include ::Api::ExceptionHandler

  before_action :authenticate!

  respond_to :json

  private

  def authenticate!
    head :unauthorized unless authorized?
  end

  def authorized?
    ActiveSupport::SecurityUtils.secure_compare(api_key, Rails.configuration.api_key)
  end

  def api_key
    (params[:apikey] || request.headers[:apikey]).to_s
  end
end
